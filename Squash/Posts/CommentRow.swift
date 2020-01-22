//
//  CommentRow.swift
//  Squash
//
//  Created by Cory Kacal on 1/21/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI



struct CommentRow: View {
    let post: Post
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(post.contents)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                .layoutPriority(100)

                Spacer()
            }
            .padding()
        
            HStack {
                Text(String(post.id))
                
                Spacer()
            }
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.9), lineWidth: 1)
        ).background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .padding([.top, .horizontal])
        
       
    }
}


/*
#if DEBUG
struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(post: Post(contents: "test post", id: 1, comment_count: 10))
    }
}
#endif
*/
