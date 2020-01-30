//
//  Subject.swift
//  Squash
//
//  Created by Cory Kacal on 1/27/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import Foundation
import SwiftUI

struct Subject {
    var subject: String
    var color: Int?
}

extension Subject: Decodable {
    enum CodingKeys: String, CodingKey {
        case subject = "subject"
        case color = "color"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        subject = try values.decode(String.self, forKey: .subject)
        color = try values.decodeIfPresent(Int.self, forKey: .color)
    }
}
