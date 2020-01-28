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
    
    func getSubjects(for opuuid: String, latitude: Double, longitude: Double, completion: @escaping (Result<[Subject], Error>) -> Void) {
        
        
        var components = URLComponents()
        components.scheme = "http"
        components.host = self.base_url
        components.port = 5000
        components.path = "/api/subjects/"
        components.queryItems = [
            URLQueryItem(name: "opuuid", value: opuuid),
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
                    let response = try self?.decoder.decode(SubjectListing.self, from: data)
                    completion(.success(response?.subjects ?? []))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    
    func makeDecision(for opuuid: String, post_number: Int, decision: Bool?, completion: @escaping (Result<String, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = "http"
        components.host = self.base_url
        components.port = 5000
        components.path = "/api/vote/"
        var json: [String: Any]
        if(decision==nil) {
        json = [
            "opuuid": opuuid,
            "post_number": String(post_number)
            ]
        } else {
            json = [
            "opuuid": opuuid,
            "descision": String(decision!),
            "post_number": String(post_number)
            ]
        }

        guard let url = components.url else {
            preconditionFailure("shit broke")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]

        request.allHTTPHeaderFields = headers

        print(opuuid)
        let postString = self.getPostString(params: json)
        request.httpBody = postString.data(using: .utf8)
        
        session.dataTask(with: request) { [weak self] data, _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                do {
                    let data = data ?? Data()
                    let response = try self?.decoder.decode(PostResponse.self, from: data)
                    completion(.success(response?.response ?? ""))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }.resume()
        

    }
    

    
    func makePost(for opuuid: String, imageuuid: String?, reply_to: Int?,
                  contents: String, subject: String?, latitude: Double, longitude: Double,
                  completion: @escaping (Result<String, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = "http"
        components.host = self.base_url
        components.port = 5000
        components.path = "/api/submit/"
        let json: [String: Any] =
            [
                "imageuuid": String(imageuuid ?? ""),
                "reply_to": reply_to,
                "opuuid": opuuid,
                "contents": contents,
                "subject": String(subject ?? ""),
                "latitude": latitude,
                "longitude": longitude
            ]

        guard let url = components.url else {
            preconditionFailure("shit broke")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]

        request.allHTTPHeaderFields = headers

        let postString = self.getPostString(params: json)
        request.httpBody = postString.data(using: .utf8)

        session.dataTask(with: request) { [weak self] data, _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                do {
                    let data = data ?? Data()
                    let response = try self?.decoder.decode(PostResponse.self, from: data)
                    completion(.success(response?.response ?? ""))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
        }.resume()

    }

    func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
}
