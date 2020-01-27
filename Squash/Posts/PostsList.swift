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
        ZStack {
            //ZStack for the floating action button
            NavigationView {
                ScrollView {
                    VStack {
                        ForEach(mainViewModel.posts) { post in
                            NavigationLink(destination: SinglePost(post: post).environmentObject(self.mainViewModel)) {
                                PostRow(post: post, cropped: true)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }.padding(.top, 10)
                .onAppear(perform: fetchPosts).navigationBarHidden(false)
                .onAppear(perform: fetchSubjects)
                .background(Image("Background"))
                    .background(NavigationConfigurator { nc in
                        nc.navigationBar.barTintColor = .yellow
                     })
                .navigationBarItems(leading:
                HStack {
                    Button(action: {}) {
                        Image(systemName: "minus.square.fill")
                            .font(.largeTitle)
                    }.foregroundColor(.pink)
                }, trailing:
                HStack {
                    Button(action: {}) {
                        Image(systemName: "plus.square.fill")
                            .font(.largeTitle)
                    }.foregroundColor(.blue)
                })
                    // 5.
                    .navigationBarTitle(Text("Names"), displayMode: .inline)

            }    .navigationViewStyle(StackNavigationViewStyle())

            VStack {
                Spinner(items: mainViewModel.subjects)
                Spacer()

            }
            
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
                        NewPost().environmentObject(self.mainViewModel)
                    })
                }
            }
        }
    }
    
    private func fetchPosts() {
        mainViewModel.fetchPosts(opUUID: "meme", latitude: 30.285610, longitude: -97.737204, number_of_posts: 10, page_number: 0)
    }
    
    private func fetchSubjects() {
        mainViewModel.fetchSubjects(opUUID: "meme", latitude: 30.285610, longitude: -97.737204)
    }
}


struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
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
