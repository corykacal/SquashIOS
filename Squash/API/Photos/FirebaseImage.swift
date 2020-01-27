//
//  FirebaseImage.swift
//  Squash
//
//  Created by Cory Kacal on 1/23/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI

let placeholder = UIImage(systemName: "photo.fill")!


struct FirebaseImage : View {

    init(id: String) {
        self.photoLoader = PhotoLoader(id)
    }

    @ObservedObject private var photoLoader: PhotoLoader

    var image: UIImage? {
        photoLoader.data.flatMap(UIImage.init)
    }

    var body: some View {
        Image(uiImage: image ?? placeholder)
        .resizable()
        .scaledToFill()
    }
}

