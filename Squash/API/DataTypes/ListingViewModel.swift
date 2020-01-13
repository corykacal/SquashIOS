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


class ListingViewModel: ObservableObject {
    let service: SquashService
    
    @Published var posts = [Post]()
    
    init(service: SquashService) {
        self.service = service
    }
    
    
}
