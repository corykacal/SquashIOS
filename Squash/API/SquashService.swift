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
        self.base_url = "ec2-18-218-80-162.us-east-2.compute.amazonaws.com"
    }
    
    func getRecentPosts(for opuuid: String, number_of_posts: Int, page_number: Int, subject: String, latitude: Double, longitude: Double, completion: @escaping (Result<[Post], Error>) -> Void) {
        
        
        var components = URLComponents()
        components.scheme = "http"
        components.host = self.base_url
        components.port = 5000
        components.path = "/api/recent/"
        components.queryItems = [
            URLQueryItem(name: "opuuid", value: opuuid),
            URLQueryItem(name: "number_of_posts", value: String(number_of_posts)),
            URLQueryItem(name: "page_number", value: String(page_number)),
            URLQueryItem(name: "subject", value: subject),
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude)),
        ]
        
        guard let url = components.url else {
            preconditionFailure("shit broke")
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
    
    
    func getComments(for opuuid: String, postNumber: Int, latitude: Double, longitude: Double, completion: @escaping (Result<[Post], Error>) -> Void) {
        
        
        var components = URLComponents()
        components.scheme = "http"
        components.host = self.base_url
        components.port = 5000
        components.path = "/api/replies/"
        components.queryItems = [
            URLQueryItem(name: "opuuid", value: opuuid),
            URLQueryItem(name: "post_number", value: String(postNumber)),
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude))
        ]
        
        guard let url = components.url else {
            preconditionFailure("shit broke")
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
