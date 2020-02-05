//
//  CaptureImageView.swift
//  Squash
//
//  Created by Cory Kacal on 2/5/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import Foundation
import SwiftUI

struct CaptureImageView {
  @Binding var isShown: Bool
  @Binding var image: Image?
    @Binding var imageURL: String
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(isShown: $isShown, image: $image, imageurl: $imageURL)
  }
}
extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}
