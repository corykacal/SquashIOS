//
//  UserPosts.swift
//  Squash
//
//  Created by Cory Kacal on 1/30/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI


struct UserPosts: View {
    
    @ObservedObject var mainViewModel: MainViewModel
    
    //Pagination stuff!
    @State private var isLoading: Bool = false
    @State private var page: Int = 1
    private let pageSize: Int = 10
    private let offset: Int = 6
    
    var body: some View {
       NavigationView {
           List {
               ForEach(mainViewModel.posts.indices, id: \.self) { index in
                   ZStack {
                       PostRow(post: self.$mainViewModel.posts[index], cropped: true).environmentObject(self.mainViewModel)

                       NavigationLink(destination: SinglePost(post: self.$mainViewModel.posts[index]).environmentObject(self.mainViewModel)) {
                           EmptyView()
                       }.buttonStyle(PlainButtonStyle())
                   }.onAppear(perform: {
                       self.listItemAppears(self.mainViewModel.posts[index])
                   })
                   .listRowInsets(.init(top: 8, leading: 10, bottom: 8, trailing: 10))
                   
               }.listRowBackground(Color("ColorBackground"))

           }
        }
    }
}


extension UserPosts {
    private func listItemAppears<Item: Identifiable>(_ item: Item) {
        if mainViewModel.posts.isThresholdItem(offset: offset,
                                 item: item) {
            isLoading = true
            
            /*
                Simulated async behaviour:
                Creates items for the next page and
                appends them to the list after a short delay
             */
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.page += 1
                self.mainViewModel.addNewPage(nextPage: self.page, numberPosts: self.pageSize)
                self.isLoading = false
            }
        }
    }
}

/*
struct UserPosts_Previews: PreviewProvider {
    static var previews: some View {
        UserPosts()
    }
}
*/
