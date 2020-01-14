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
    var id: Int
    var comment_count: Int
    
}

extension Post: Decodable {
    enum CodingKeys: String, CodingKey {
        case contents = "contents"
        case id = "post_number"
        case comment_count = "comment_count"
    }
    
    init(from decoder: Decoder) throws {
        print("made it here")
        let values = try decoder.container(keyedBy: CodingKeys.self)

        contents = try values.decode(String.self, forKey: .contents)
        id = try values.decode(Int.self, forKey: .id)
        comment_count = try values.decode(Int.self, forKey: .comment_count)
    }
}
