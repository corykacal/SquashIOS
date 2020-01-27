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
        return UIView(SVGNamed: svgName) { (svgLayer) in svgLayer.boundingBox = CGRect(x: 0, y: 0, width: 100, height: 100) }    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
