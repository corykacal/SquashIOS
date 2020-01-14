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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(mainViewModel.posts) { post in
                    PostRow(post: post)
                }
            }
        }
        .onAppear(perform: fetchPosts)
    }
    
    private func fetchPosts() {
        mainViewModel.fetchPosts(opUUID: "meme", latitude: 30.285610, longitude: -97.737204, number_of_posts: 10, page_number: 0)
    }
}

#if DEBUG
struct PostsList_Previews: PreviewProvider {
    static var previews: some View {
        PostsList(mainViewModel: MainViewModel(service: SquashService()))
    }
}
#endif
