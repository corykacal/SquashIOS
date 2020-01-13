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
                Text(post.subject)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }
        }
    }
}


#if DEBUG
struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(post: Post(contents: "test post", subject: "Memes", imageUUID: "", id: 1, uniqueCommenter: 0, opUUID: "", reply_to: 0, comment_count: 10, decision: false, up: 1, down: 3, timeStamp: TimeInterval(), subject_color: 1231222, subject_svg: "", subject_image: ""))
    }
}
#endif
