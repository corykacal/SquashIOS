//
//  SinglePost.swift
//  Squash
//
//  Created by Cory Kacal on 1/21/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI
import Firebase
import SwiftSVG


struct SinglePost: View {
    let post: Post
    
    @EnvironmentObject var mainViewModel: MainViewModel
    

    
    var body: some View {
            List {
                PostRow(post: self.post, fullImage: true)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
                
                ForEach(mainViewModel.comments) { post in
                    CommentRow(post: post)
                }.listRowBackground(Color.clear)
            }.onAppear(perform: fetchComments)
        .onDisappear(perform: resetView)
    }
    
    private func fetchComments() {
        mainViewModel.fetchComments(opUUID: "meme", postNumber: post.id,  latitude: 30.285610, longitude: -97.737204)
    }
    
    private func resetView() {
        print("closing view!!!!!")
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
