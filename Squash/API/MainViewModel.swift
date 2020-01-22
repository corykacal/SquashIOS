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


class MainViewModel: ObservableObject {
    let service: SquashService
    
    
    @Published var showFullScreen = false
    @Published var posts = [Post]()
    @Published var comments = [Post]()
    
    init(service: SquashService) {
        self.service = service
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
    
    
}
