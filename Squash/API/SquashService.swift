//
//  SquashService.swift
//  Squash
//
//  Created by Cory Kacal on 1/12/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import Foundation

class SquashService {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let base_url: String
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
        self.base_url = "ec2-18-218-80-162.us-east-2.compute.amazon.aws.com"
    }
    
    func getRecentPosts(for opuuid: String, number_of_posts: Int, page_number: Int, subject: String, latitude: Double, longitude: Double, completion: @escaping (Result<[Post], Error>) -> Void) {
        
        let endpoint = "/api/recent/"
        
        guard let url = URL(string: self.base_url + endpoint) else {
            preconditionFailure("idk how this works lmao")
        }
        
        session.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                do {
                    let data = data ?? Data()
                    let response = try self?.decoder.decode(Listing.self, from: data)
                    completion(.success(response?.posts ?? []))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
