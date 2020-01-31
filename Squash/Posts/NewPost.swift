//
//  NewPost.swift
//  Squash
//
//  Created by Cory Kacal on 1/21/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI

struct NewPost: View {
    
    @State var content: String = ""
    
    @EnvironmentObject var mainViewModel: MainViewModel

    @Binding var isModal: Bool

    var body: some View {
        ZStack {

            VStack(spacing: 5) {


                TextField("meme", text: $content)


                Button(action: {
                    self.mainViewModel.makePost(imageuuid: nil, reply_to: nil, contents: self.content, subject: nil) { success in
                        if(success) {
                            self.mainViewModel.fetchMyPosts(number_of_posts: 40, page_number: 2)
                            self.isModal = false
                        }
                    }
                    
                }, label: {
                    Text("Post")
                        .font(.system(.largeTitle))
                        .padding(.all, 30)

                        .foregroundColor(Color.white)
                }).background(RoundedRectangle(cornerRadius: 10).fill(Color.yellow)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 60, alignment: .topLeading))
                
                Spacer()
            }.padding(.all, 10)
                .padding(.top, 60)
            .background(Image("Background"))
                .onDisappear(perform: cleanup)
        
            VStack {
                Spinner(items: mainViewModel.subjects)
                    .padding(.top, 15)
                Spacer()

            }

        }
        
        
    }
    
    private func cleanup() {
    }
}

struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
        }
    }
}


/*
#if DEBUG
struct NewPost_Previews: PreviewProvider {
    static var previews: some View {
        NewPost(isM)
    }
}
#endif
*/
