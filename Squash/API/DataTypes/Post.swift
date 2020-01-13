//
//  Post.swift
//  Squash
//
//  Created by Cory Kacal on 1/12/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import Foundation
import SwiftUI

struct Post: Identifiable {
    var contents: String
    var subject: String
    var imageUUID: String
    var id: Int
    var uniqueCommenter: Int
    var opUUID: String
    var reply_to: Int
    var comment_count: Int
    var decision: Bool
    var up: Int
    var down: Int
    var timeStamp: TimeInterval
    var subject_color: Int
    var subject_svg: String
    var subject_image: String
    
}

extension Post: Decodable {
    enum CodingKeys: String, CodingKey {
        case contents = "contents"
        case subject = "subject"
        case imageUUID = "imageuuid"
        case id = "post_number"
        case uniqueCommenter = "unique_commenter"
        case opUUID = "opuuid"
        case reply_to = "reply_to"
        case comment_count = "comment_count"
        case decision = "descision"
        case up = "up"
        case down = "down"
        case timeStamp = "timestamp"
        case subject_color = "color"
        case subject_svg = "svg"
        case subject_image = "image"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        contents = try values.decode(String.self, forKey: .contents)
        subject = try values.decode(String.self, forKey: .subject)
        imageUUID = try values.decode(String.self, forKey: .imageUUID)
        id = try values.decode(Int.self, forKey: .id)
        uniqueCommenter = try values.decode(Int.self, forKey: .uniqueCommenter)
        opUUID = try values.decode(String.self, forKey: .opUUID)
        reply_to = try values.decode(Int.self, forKey: .reply_to)
        comment_count = try values.decode(Int.self, forKey: .comment_count)
        decision = try values.decode(Bool.self, forKey: .decision)
        up = try values.decode(Int.self, forKey: .up)
        down = try values.decode(Int.self, forKey: .down)
        timeStamp = try values.decode(TimeInterval.self, forKey: .timeStamp)
        subject_color = try values.decode(Int.self, forKey: .subject_color)
        subject_svg = try values.decode(String.self, forKey: .subject_svg)
        subject_image = try values.decode(String.self, forKey: .subject_image)
    }
}
