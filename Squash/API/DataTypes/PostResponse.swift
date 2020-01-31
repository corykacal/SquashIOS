//
//  PostResponse.swift
//  Squash
//
//  Created by Cory Kacal on 1/27/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import Foundation


struct PostResponse {
    var response: String
}


extension PostResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case response = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        response = try values.decode(String.self, forKey: .response)
    }
}
