//
//  SVGImage.swift
//  Squash
//
//  Created by Cory Kacal on 1/23/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI
import SwiftSVG

struct SVGImage: UIViewRepresentable {
    let svgName: String
    
    func makeUIView(context: Context) -> UIView {
        return UIView(SVGNamed: svgName)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
