//
//  Coordinator.swift
//  Squash
//
//  Created by Cory Kacal on 2/5/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import Foundation
import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  @Binding var isCoordinatorShown: Bool
  @Binding var imageInCoordinator: Image?
  @Binding var imageURL: String
    init(isShown: Binding<Bool>, image: Binding<Image?>, imageurl: Binding<String>) {
    _isCoordinatorShown = isShown
    _imageInCoordinator = image
    _imageURL = imageurl
  }
  func imagePickerController(_ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
    guard let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else {
        return
    }
    imageURL = imageUrl.path
     imageInCoordinator = Image(uiImage: unwrapImage)
     isCoordinatorShown = false
  }
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     isCoordinatorShown = false
  }
}
