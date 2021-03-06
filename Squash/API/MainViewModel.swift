//
//  ListingViewModel.swift
//  Squash
//
//  Created by Cory Kacal on 1/12/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import Firebase
import FirebaseStorage
import CoreLocation


class MainViewModel: ObservableObject {
    let service: SquashService

    @ObservedObject var locationManager: LocationManager
    
    @Published var showFullScreen = false
    @Published var posts = [Post(contents: "", id: 0, timestamp: Date(), subject: nil, imageuuid: nil, commentCount: 0, decision: nil, up: 0, down: 0)]
    @Published var hotPosts = [Post(contents: "", id: 0, timestamp: Date(), subject: nil, imageuuid: nil, commentCount: 0, decision: nil, up: 0, down: 0)]
    @Published var comments = [Post]()
    @Published var userPosts = [Post(contents: "", id: 0, timestamp: Date(), subject: nil, imageuuid: nil, commentCount: 0, decision: nil, up: 0, down: 0)]
    @Published var user = Auth.auth().currentUser
    @Published var subjects = [Subject(subject: "All", color: nil)]
    @Published var userData = UserData(totalUp: 0, totalDown: 0, postUp: 0, postDown: 0, commentUp: 0, commentDown: 0, postWithoutImage: 0, postWithImage: 0, totalComments: 0, totalPosts: 0, pointsGiven: 0, pointsTaken: 0)
        
    init(service: SquashService, user: User?, locationManager: LocationManager) {
        self.service = service
        self.user = user
        self.locationManager = locationManager
    }
    
    func getUid() -> String? {
        return self.user?.uid
    }
    
    private func getLatitude() -> Double {
        return self.locationManager.lastLocation!.coordinate.latitude
    }
    
    private func getLongitude() -> Double {
        return self.locationManager.lastLocation!.coordinate.longitude
    }
    
    func uploadImage(imageURL: String, uuid: String) {
        // File located on disk
        let localFile = URL(string: "file://\(imageURL)")!
        
        let storageRef = Storage.storage().reference()

        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("images/images/"+uuid)

        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putFile(from: localFile, metadata: nil) { metadata, error in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
          riversRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
          }
        }
    }
    
    func fetchMyPosts(number_of_posts: Int, page_number: Int) {
        service.getUserPosts(for: getUid()!, number_of_posts: number_of_posts, page_number: page_number) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self?.userPosts = posts
                case .failure:
                    self?.userPosts = []
                }
            }
        }
    }
    
    func fetchPosts(number_of_posts: Int, page_number: Int, completion: @escaping (Bool) -> Void) {
        print(self.locationManager.lastLocation)
        service.getRecentPosts(for: getUid()!, number_of_posts: number_of_posts, page_number: page_number, subject: "All", latitude: getLatitude(), longitude: getLongitude()) { [weak self] result in
            DispatchQueue.main.sync {
                switch result {
                case .success(let posts):
                    print("setting post now!!!!")
                    self?.posts = posts
                    completion(true)
                case .failure:
                    completion(false)
                }
            }
        }
    }
    
    func fetchHotPosts(number_of_posts: Int, page_number: Int, completion: @escaping (Bool) -> Void) {
        service.getHotPosts(for: getUid()!, number_of_posts: number_of_posts, page_number: page_number, subject: "All", latitude: getLatitude(), longitude: getLongitude()) { [weak self] result in
            DispatchQueue.main.sync {
                switch result {
                case .success(let posts):
                    print("setting hot post now")
                    print(self?.hotPosts.capacity)
                    self?.hotPosts = posts
                    print(self?.hotPosts.capacity)
                    completion(true)
                case .failure:
                    completion(false)
                }
            }
        }
    }

    
    func fetchComments(postNumber: Int, latitude: Double, longitude: Double) {
        service.getComments(for: getUid()!, postNumber: postNumber, latitude: latitude, longitude: longitude) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let comments):
                    self?.comments = comments
                case .failure:
                    self?.comments = []
                }
            }
        }
    }
    
    func clearComments() {
        self.comments.removeAll()
    }
    
    func fetchSubjects() {
        service.getSubjects(for: getUid()!, latitude: getLatitude(), longitude: getLongitude()) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let subjects):
                    self?.subjects = subjects
                    print(subjects)
                case .failure:
                    self?.subjects = []
                }
            }
        }
    }
    
    func makeDecision(decision: Bool?, post_number: Int) {
        service.makeDecision(for: getUid()!, post_number: post_number, decision: decision) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response)
                case .failure:
                    print("error")
                }
            }
        }
    }
    
    func makePost(imageuuid: String?, reply_to: Int?, contents: String, subject: String?, completion: @escaping (Bool) -> Void) {
        service.makePost(for: getUid()!, imageuuid: imageuuid, reply_to: reply_to, contents: contents, subject: subject, latitude: getLatitude(), longitude: getLongitude()) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response)
                    completion(true)
                case .failure:
                    print("error")
                    completion(false)
                }
            }
        }
    }
    
    func addNewPage(nextPage: Int, numberPosts: Int) {
        print("fdsafdsafds")
        service.getRecentPosts(for: getUid()!, number_of_posts: numberPosts, page_number: nextPage, subject: "All", latitude: getLatitude(), longitude: getLongitude()) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    print("LOADING---------------------------------------")
                    self?.posts.append(contentsOf: posts)
                case .failure:
                    print("fail")
                }
            }
        }
    }
    
    func fetchUserData() {
        service.getUserData(for: getUid()!) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userData):
                    self?.userData = userData[0]
                case .failure:
                    print("fail")
                }
            }
        }
    }

    
    
}
