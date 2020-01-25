//
//  PostsList.swift
//  Squash
//
//  Created by Cory Kacal on 1/13/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI

struct PostsList: View {
    @ObservedObject var mainViewModel: MainViewModel
    
    @State private var subject = "All"
    
    @State var isModal: Bool = false

    
    var body: some View {
        NavigationView {
            //ZStack for the floating action button
            ZStack {
                
                ScrollView {
                    VStack {
                        ForEach(mainViewModel.posts) { post in
                            NavigationLink(destination: SinglePost(post: post).environmentObject(self.mainViewModel)) {
                                PostRow(post: post, fullImage: false)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }.onAppear(perform: fetchPosts)

                .background(Image("Background"))
                 
                VStack {
                    Spacer()
                    HStack {
                        Spacer()

                        Button(action: {
                            self.isModal = true
                            }, label: {
                                Text("+")
                                    .font(.system(.largeTitle))
                                    .frame(width: 77, height: 70)
                                    .foregroundColor(Color.white)
                                    .padding(.bottom, 7)
                            })
                            .background(Color.blue)
                            .cornerRadius(38.5)
                            .padding()
                            .opacity(0.7)
                            .shadow(color: Color.black.opacity(0.3),
                                    radius: 3,
                                    x: 3,
                                    y: 3)
                        .sheet(isPresented: $isModal, content: {
                            NewPost()
                        })
                    }
                }

            }
        }
    }
    
    private func fetchPosts() {
        mainViewModel.fetchPosts(opUUID: "meme", latitude: 30.285610, longitude: -97.737204, number_of_posts: 10, page_number: 0)
    }
}

/*
#if DEBUG
struct PostsList_Previews: PreviewProvider {
    static var previews: some View {
        PostsList(mainViewModel: MainViewModel(service: SquashService()))
    }
}
#endif
*/
