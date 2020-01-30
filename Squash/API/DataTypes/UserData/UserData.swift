//
//  UserData.swift
//  Squash
//
//  Created by Cory Kacal on 1/30/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import Foundation
import SwiftUI

struct UserData {
    var totalUp: Int
    var totalDown: Int
    var postUp: Int
    var postDown: Int
    var commentUp: Int
    var commentDown: Int
    var postWithoutImage: Int
    var postWithImage: Int
    var totalComments: Int
    var totalPosts: Int
    var pointsGiven: Int
    var pointsTaken: Int
}

extension UserData: Decodable {
    enum CodingKeys: String, CodingKey {
        case postUp = "post_up"
        case postDown = "post_down"
        case commentUp = "comment_up"
        case commentDown = "comment_down"
        case postWithoutImage = "post_without_image"
        case postWithImage = "post_with_image"
        case totalComments = "total_comments"
        case totalPosts = "total_posts"
        case pointsGiven = "points_given"
        case pointsTaken = "points_taken"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
            
        postUp = try values.decode(Int.self, forKey: .postUp)
        postDown = try values.decode(Int.self, forKey: .postDown)
        commentUp = try values.decode(Int.self, forKey: .commentUp)
        commentDown = try values.decode(Int.self, forKey: .commentDown)
        postWithoutImage = try values.decode(Int.self, forKey: .postWithoutImage)
        postWithImage = try values.decode(Int.self, forKey: .postWithImage)
        totalComments = try values.decode(Int.self, forKey: .totalComments)
        totalPosts = try values.decode(Int.self, forKey: .totalPosts)
        pointsGiven = try values.decode(Int.self, forKey: .pointsGiven)
        pointsTaken = try values.decode(Int.self, forKey: .pointsTaken)
        
        totalUp = postUp + commentUp
        totalDown = postDown + commentDown
    }
}
