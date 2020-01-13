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
    
    @Published var posts = [Post]()
    
    init(service: SquashService) {
        self.service = service
    }
    
    func fetchPosts(opUUID: String, latitude: Double, longitude: Double, number_of_posts: Int, page_number: Int) {
        service.getRecentPosts(for: <#T##String#>, number_of_posts: <#T##Int#>, page_number: <#T##Int#>, subject: <#T##String#>, latitude: <#T##Double#>, longitude: <#T##Double#>) { [weak self] result in
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
    
    
}
