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
    let didChange = PassthroughSubject<Data?, Never>()
    var data: Data? = nil {
        didSet { didChange.send(data) }
    }

    init(_ id: String?){
        // the path to the image
        let url = "images/images/" + (id ?? "notexists")
        let storage = Storage.storage()
        let ref = storage.reference().child(url)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("error")
            }

            DispatchQueue.main.async {
                print("found le shit")
                self.data = data
            }
        }
    }
}
