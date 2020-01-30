//
//  UserDataListing.swift
//  Squash
//
//  Created by Cory Kacal on 1/30/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import Foundation

struct UserDataListing {
    var userData: [UserData]
}


extension UserDataListing: Decodable {
    enum CodingKeys: String, CodingKey {
        case userData = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
                
        userData = try values.decode([UserData].self, forKey: .userData)
    }
}
