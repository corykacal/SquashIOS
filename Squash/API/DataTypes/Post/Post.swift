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
    var commentCount: Int?
    var points: Int
    var decision: Bool?
    var color: Int?
    var veggie_url: String?
    var veggie_color: Int?
}

extension Post: Decodable {
    enum CodingKeys: String, CodingKey {
        case contents = "contents"
        case id = "post_number"
        case timestamp = "timestamp"
        case subject = "subject"
        case imageuuid = "imageuuid"
        case commentCount = "comment_count"
        case up = "up"
        case down = "down"
        case decision = "descision"
        case color = "color"
        case veggie_url = "veggie"
        case veggie_color = "veggie_color"
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
        commentCount = try values.decodeIfPresent(Int.self, forKey: .commentCount)
        let up = try values.decode(Int.self, forKey: .up)
        let down = try values.decode(Int.self, forKey: .down)
        points = up-down
        decision = try values.decodeIfPresent(Bool.self, forKey: .decision)
        color = try values.decodeIfPresent(Int.self, forKey: .color)
        veggie_url = try values.decodeIfPresent(String.self, forKey: .veggie_url)
        veggie_color = try values.decodeIfPresent(Int.self, forKey: .veggie_color)
    }
}


/*
another time i will do this

 class Post: ObservableObject, Hashable, Identifiable, Decodable {
     static func == (lhs: Post, rhs: Post) -> Bool {
         lhs.id == rhs.id && lhs.subject == rhs.subject
     }
     
     func hash(into hasher: inout Hasher) {
         hasher.combine(id)
         hasher.combine(subject)
     }
     
     @Published var contents: String
     @Published var id: Int
     @Published var timestamp: Date
     @Published var subject: String?
     @Published var imageuuid: String?
     @Published var commentCount: Int?
     @Published var points: Int
     @Published var decision: Bool?
     
     enum CodingKeys: String, CodingKey {
         case contents = "contents"
         case id = "post_number"
         case timestamp = "timestamp"
         case subject = "subject"
         case imageuuid = "imageuuid"
         case commentCount = "comment_count"
         case up = "up"
         case down = "down"
         case decision = "descision"
     }
     
     init(contents: String, id: Int, timestamp: Date, subject: String?, imageuuid: String?, commentCount: Int?, points: Int, decision: Bool?) {
         self.contents = contents
         self.id = id
         self.timestamp = timestamp
         self.subject = subject
         self.imageuuid = imageuuid
         self.commentCount = commentCount
         self.points = points
         self.decision = decision
     }
     
     required init(from decoder: Decoder) throws {
         let values = try decoder.container(keyedBy: CodingKeys.self)
         let formatter = DateFormatter()
         formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"



         contents = try values.decode(String.self, forKey: .contents)
         id = try values.decode(Int.self, forKey: .id)
         let timestampString = try values.decode(String.self, forKey: .timestamp)
         timestamp = formatter.date(from: timestampString)!
         imageuuid = try values.decodeIfPresent(String.self, forKey: .imageuuid)
         subject = try values.decodeIfPresent(String.self, forKey: .subject)
         commentCount = try values.decodeIfPresent(Int.self, forKey: .commentCount)
         let up = try values.decode(Int.self, forKey: .up)
         let down = try values.decode(Int.self, forKey: .down)
         points = up-down
         decision = try values.decodeIfPresent(Bool.self, forKey: .decision)
     }

     
 }

 */
