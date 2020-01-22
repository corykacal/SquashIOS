//
//  NewPost.swift
//  Squash
//
//  Created by Cory Kacal on 1/21/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI

struct NewPost: View {
    
    @State var content: String = ""

    var body: some View {
        VStack {
            TextField("Whats on your mind?", text: $content)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.9), lineWidth: 1)
                ).background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .padding(.all, 50)
                .lineLimit(-4)

            Button(action: {
            }, label: {
                Text("Post")
                    .font(.system(.largeTitle))
                    .padding(.all, 50)

                    .foregroundColor(Color.white)
            }).background(RoundedRectangle(cornerRadius: 10).fill(Color.yellow)                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 60, alignment: .topLeading))
            
            Spacer()
        }.padding(.all, 10)
    }
}


#if DEBUG
struct NewPost_Previews: PreviewProvider {
    static var previews: some View {
        NewPost()
    }
}
#endif
