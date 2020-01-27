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
    @Published var posts = [Post(contents: "", id: 0, timestamp: Date(), subject: nil, imageuuid: nil, commentCount: 0)]
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
    
    func fetchPosts(opUUID: String, latitude: Double, longitude: Double, number_of_posts: Int, page_number: Int) {
        service.getRecentPosts(for: opUUID, number_of_posts: number_of_posts, page_number: page_number, subject: "All", latitude: latitude, longitude: longitude) { [weak self] result in
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
    
    func fetchComments(opUUID: String, postNumber: Int, latitude: Double, longitude: Double) {
        service.getComments(for: opUUID, postNumber: postNumber, latitude: latitude, longitude: longitude) { [weak self] result in
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
    
    func fetchSubjects(opUUID: String, latitude: Double, longitude: Double) {
        service.getSubjects(for: opUUID, latitude: latitude, longitude: longitude) { [weak self] result in
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

    
    
}
