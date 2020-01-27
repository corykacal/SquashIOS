//
//  SubjectListing.swift
//  Squash
//
//  Created by Cory Kacal on 1/27/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import Foundation

struct SubjectListing {
    var subjects = [Subject]()
}


extension SubjectListing: Decodable {
    enum CodingKeys: String, CodingKey {
        case subjects = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        subjects = try values.decode([Subject].self, forKey: .subjects)
    }
}
