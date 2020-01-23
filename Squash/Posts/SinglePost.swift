//
//  SinglePost.swift
//  Squash
//
//  Created by Cory Kacal on 1/21/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI
import Firebase


struct SinglePost: View {
    let post: Post
    @ObservedObject var mainViewModel: MainViewModel

    
    var body: some View {
            List {
                PostRow(post: self.post)

                ForEach(mainViewModel.comments) { post in
                    CommentRow(post: post)
                }.listRowBackground(Color.clear)
            }.onAppear(perform: fetchComments)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .layoutPriority(10)


    }
    
    private func fetchComments() {
        mainViewModel.fetchComments(opUUID: "meme", postNumber: post.id,  latitude: 30.285610, longitude: -97.737204)
    }
}



/*
#if DEBUG
struct SinglePost_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(post: Post(contents: "test post", id: 1, comment_count: 10))
    }
}
#endif
*/
