//
//  PhotoLoader.swift
//  Squash
//
//  Created by Cory Kacal on 1/22/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//



import Foundation
import SwiftUI
import Combine
import FirebaseStorage

final class PhotoLoader : ObservableObject {
    static let cache = NSCache<NSString, NSData>()
    
    let didChange = PassthroughSubject<Data?, Never>()
    @Published var data: Data? = nil {
        didSet { didChange.send(data) }
    }

    init(_ id: String?){
        // the path to the image
        if let cachedImage = PhotoLoader.cache.object(forKey: NSString(string: id!)) as Data? {
            self.data = cachedImage
            return
        }
        let url = "images/images/" + (id ?? "notexists")
        let storage = Storage.storage()
        let ref = storage.reference().child(url)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
            }

            DispatchQueue.main.async {
                self.data = data
                PhotoLoader.cache.setObject(data! as NSData, forKey: NSString(string: id!))
            }
        }
    }
}
