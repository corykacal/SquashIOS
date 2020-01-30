//
//  PostsList.swift
//  Squash
//
//  Created by Cory Kacal on 1/13/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI


extension RandomAccessCollection where Self.Element: Identifiable {
    func isThresholdItem<Item: Identifiable>(offset: Int, item: Item) -> Bool {
        print("isThresholdItem--------------------------")
        guard !isEmpty else {
            return false
        }
        
        guard let itemIndex = firstIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) }) else {
            return false
        }
        
        let distance = self.distance(from: itemIndex, to: endIndex)
        let offset = offset < count ? offset : count - 1
        return offset == (distance - 1)
    }
}




struct PostsList: View {
    @ObservedObject var mainViewModel: MainViewModel
    
    @State private var subject = "All"
    @State var isModal: Bool = false

    //Pagination stuff!
    @State private var isLoading: Bool = false
    @State private var page: Int = 2
    private let pageSize: Int = 40
    private let offset: Int = 9


    
    var body: some View {
        ZStack {
            //ZStack for the floating action button
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
                    
                    if self.isLoading {
                        Divider()
                        Text("Loading ...")
                            .padding(.vertical)
                    }
 
                }
                    
                    .background(NavigationConfigurator { nc in
                        nc.navigationBar.barTintColor = UIColor.systemYellow
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

            }
                
            .navigationViewStyle(StackNavigationViewStyle())

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
                        NewPost(isModal: self.$isModal).environmentObject(self.mainViewModel)
                    })
                }
            }
        }
    }
    
    private func fetchPosts() {
        mainViewModel.fetchPosts(number_of_posts: pageSize, page_number: 1)
    }
    
    private func fetchSubjects() {
        mainViewModel.fetchSubjects()
    }
}


extension PostsList {
    private func listItemAppears<Item: Identifiable>(_ item: Item) {
        if mainViewModel.posts.isThresholdItem(offset: offset,
                                 item: item) {
            isLoading = true
            print("listItemAppears_-_-_-_-_-_-_-_-_-_-_-_-_")
            
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
