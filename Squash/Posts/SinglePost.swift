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
    
    @ObservedObject var mainViewModel: MainViewModel
    
    @Binding var isSingle: Bool
    
    @State var content: String = ""

    @State private var name = Array<String>.init(repeating: "", count: 3)

    
    var body: some View {
        KeyboardHost {

        ZStack {
            
            NavigationView {
                ScrollView {
                    VStack {
                        PostRow(post: self.$post, cropped: false).environmentObject(self.mainViewModel)
                            .padding(9)

                        Divider().padding(.top, 5)
                            .foregroundColor(Color.yellow)
                            .padding(.horizontal, 20)
                        
                        ForEach(mainViewModel.comments) { comment in
                            CommentRow(post: comment, mainViewModel: self.mainViewModel)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                        }
                        
                    }.padding(.top, 50)
                        .padding(.bottom, 200)
                }.background(Image("Background"))
                .navigationBarHidden(true)
                    .edgesIgnoringSafeArea(.all)

            }.onAppear(perform: fetchComments)
                .onDisappear(perform: resetView)
        
            
            VStack(spacing: 0){
                
                Spacer()
                
                HStack {
                    
                    TextField("make a comment..", text: $content)
                        .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 20, idealHeight: 20, maxHeight: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor(white: 1.0, alpha: 1.0))))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.3), lineWidth: 1)
                        )
                
                        Button(action: {
                            //send comment post
                            self.mainViewModel.makePost(imageuuid: nil, reply_to: self.post.id, contents: self.content, subject: nil) {_ in
                            }
                        }) {
                            Image(systemName: "arrowtriangle.right.square.fill")
                                .font(.system(size: 44))
                                .foregroundColor(Color(.sRGB, red: 0/255, green: 0/255, blue: 0/255, opacity: 0.4))
                        }.padding([.trailing], 6)
                }.background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.yellow))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.3), lineWidth: 1)
                )


                    
                


        
            }.padding(.all, 6)
            
                
            
            
        }.animation(.easeInOut(duration: 0.1))
        }
    }
    
    private func fetchComments() {
        isSingle = true
        mainViewModel.fetchComments(postNumber: post.id,  latitude: 30.285610, longitude: -97.737204)
    }
    
    private func resetView() {
        isSingle = false
        self.mainViewModel.clearComments()
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
