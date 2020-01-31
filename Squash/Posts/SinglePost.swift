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
    @Binding var post: Post
    
    @EnvironmentObject var mainViewModel: MainViewModel
    
    @Binding var isSingle: Bool
    

    
    var body: some View {
            NavigationView {
                ScrollView {
                    VStack {
                        PostRow(post: self.$post, cropped: false).environmentObject(self.mainViewModel)
                            .padding(9)

                        Divider().padding(.top, 5)
                            .foregroundColor(Color.yellow)
                            .padding(.horizontal, 20)
                        
                        ForEach(mainViewModel.comments) { post in
                            CommentRow(post: post).padding(.vertical, 5)
                        }
                        
                    }.padding(.top, 50)
                        .padding(.bottom, 200)
                }.background(Image("Background"))
                .navigationBarHidden(true)
                    .edgesIgnoringSafeArea(.all)

            }.onAppear(perform: fetchComments)
    }
    
    private func fetchComments() {
        isSingle = true
        mainViewModel.fetchComments(postNumber: post.id,  latitude: 30.285610, longitude: -97.737204)
    }
    
    private func resetView() {
        isSingle = false
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
