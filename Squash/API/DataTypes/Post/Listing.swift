//
//  Listing.swift
//  Squash
//
//  Created by Cory Kacal on 1/12/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import Foundation

struct Listing {
    var posts = [Post]()
}


extension Listing: Decodable {
    enum CodingKeys: String, CodingKey {
        case posts = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        posts = try values.decode([Post].self, forKey: .posts)
    }
}
