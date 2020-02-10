//
//  ForEachBuilder.swift
//  Squash
//
//  Created by Cory Kacal on 2/10/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI

struct ForEachBuilder<Content>: View where Content: View {

    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
    }

}
