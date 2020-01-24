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
    var timestamp: Date
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
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"



        contents = try values.decode(String.self, forKey: .contents)
        id = try values.decode(Int.self, forKey: .id)
        let timestampString = try values.decode(String.self, forKey: .timestamp)
        timestamp = formatter.date(from: timestampString)!
        imageuuid = try values.decodeIfPresent(String.self, forKey: .imageuuid)
        subject = try values.decodeIfPresent(String.self, forKey: .subject)
    }
}
