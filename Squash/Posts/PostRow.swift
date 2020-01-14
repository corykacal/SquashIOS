//
//  PostRow.swift
//  Squash
//
//  Created by Cory Kacal on 1/12/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI

struct PostRow: View {
    let post: Post
    
    var body: some View {
        HStack {
            Image(systemName: "photo.fill")
                .font(.largeTitle)
            
            VStack(alignment: .leading) {
                Text(post.contents)
                    .font(.headline)
                Text(String(post.comment_count))
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }
        }
    }
}


#if DEBUG
struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(post: Post(contents: "test post", id: 1, comment_count: 10))
    }
}
#endif
