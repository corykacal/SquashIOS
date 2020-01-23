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
    var timestamp: String
    var subject: String?
    var imageuuid: String?
}

extension Post: Decodable {
    enum CodingKeys: String, CodingKey {
        case contents = "contents"
        case id = "post_number"
        case timestamp = "timestamp"
        case subject = "subject"
        case imageuuid = "imageuuid"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        contents = try values.decode(String.self, forKey: .contents)
        id = try values.decode(Int.self, forKey: .id)
        timestamp = try values.decode(String.self, forKey: .timestamp)
        imageuuid = try values.decodeIfPresent(String.self, forKey: .imageuuid)
        subject = try values.decodeIfPresent(String.self, forKey: .subject)
    }
}
