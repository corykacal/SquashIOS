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


class MainViewModel: ObservableObject {
    let service: SquashService
    
    
    @Published var showFullScreen = false
    @Published var posts = [Post(contents: "", id: 0, timestamp: Date(), subject: nil, imageuuid: nil, commentCount: 0, points: 0, decision: nil)]
    @Published var comments = [Post]()
    @Published var user = Auth.auth().currentUser
    @Published var subjects = [Subject(subject: "All", color: nil)]
        
    init(service: SquashService, user: User?) {
        self.service = service
        self.user = user
    }
    
    func getUid() -> String? {
        return self.user?.uid
    }
    
    func fetchPosts(number_of_posts: Int, page_number: Int) {
        service.getRecentPosts(for: getUid()!, number_of_posts: number_of_posts, page_number: page_number, subject: "All", latitude: 30.285610, longitude: -97.737204) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self?.posts = posts
                case .failure:
                    self?.posts = []
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
    
    func fetchSubjects() {
        service.getSubjects(for: getUid()!, latitude: 30.285610, longitude: -97.737204) { [weak self] result in
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
    
    func makePost(imageuuid: String?, reply_to: Int?, contents: String, subject: String?) {
        service.makePost(for: getUid()!, imageuuid: imageuuid, reply_to: reply_to, contents: contents, subject: subject, latitude: 30.285610, longitude: -97.737204) { [weak self] result in
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
    
    func addNewPage(nextPage: Int, numberPosts: Int) {
        print("fdsafdsafds")
        service.getRecentPosts(for: getUid()!, number_of_posts: numberPosts, page_number: nextPage, subject: "All", latitude: 30.285610, longitude: -97.737204) { [weak self] result in
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

    
    
}
