//
//  KeyboardHost.swift
//  Squash
//
//  Created by Cory Kacal on 2/6/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI

struct KeyboardHost<Content: View>: View {
    let view: Content

    @State private var keyboardHeight: CGFloat = 0

    private let showPublisher = NotificationCenter.Publisher.init(
        center: .default,
        name: UIResponder.keyboardWillShowNotification
    ).map { (notification) -> CGFloat in
        if let rect = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
            return rect.size.height
        } else {
            return 0
        }
    }

    private let hidePublisher = NotificationCenter.Publisher.init(
        center: .default,
        name: UIResponder.keyboardWillHideNotification
    ).map {_ -> CGFloat in 0}

    // Like HStack or VStack, the only parameter is the view that this view should layout.
    // (It takes one view rather than the multiple views that Stacks can take)
    init(@ViewBuilder content: () -> Content) {
        view = content()
    }

    var body: some View {
        VStack(spacing: 0) {
            view
            Rectangle()
                .frame(height: (keyboardHeight == 0 ? keyboardHeight : keyboardHeight - 85))
                .animation(.easeInOut(duration: 0.1))
                .foregroundColor(Color("ColorBackground"))
        }.onReceive(showPublisher.merge(with: hidePublisher)) { (height) in
            self.keyboardHeight = height
        }
    }
}
