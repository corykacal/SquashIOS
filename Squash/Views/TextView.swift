//
//  TextView.swift
//  Squash
//
//  Created by Cory Kacal on 1/27/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    let text: String


    func makeUIView(context: Context) -> UITextView {

        let myTextView = UITextView()
        myTextView.font = UIFont(name: "HelveticaNeue", size: 15)
        myTextView.isScrollEnabled = true
        myTextView.isEditable = false
        myTextView.isUserInteractionEnabled = true
        myTextView.backgroundColor = UIColor(white: 0.0, alpha: 0.05)
        myTextView.text = self.text
        return myTextView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
