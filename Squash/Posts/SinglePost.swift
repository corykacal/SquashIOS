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
            NavigationView {
                ScrollView {
                    VStack {
                        PostRow(post: self.post, cropped: false).environmentObject(self.mainViewModel)

                        ForEach(mainViewModel.comments) { post in
                            CommentRow(post: post)
                        }
                        
                    }
                }.background(Image("Background"))

            }.onAppear(perform: fetchComments)
                .onDisappear(perform: resetView)
    }
    
    private func fetchComments() {
        mainViewModel.fetchComments(postNumber: post.id,  latitude: 30.285610, longitude: -97.737204)
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
