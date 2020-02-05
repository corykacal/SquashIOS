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
    
    @State var image: Image? = nil
    
    @State var showCaptureImageView: Bool = false

    @State var imageURL: String = ""

    var body: some View {
        ZStack {
            

            

            VStack(spacing: 5) {


                TextView(text: $content)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 50, idealHeight: 50, maxHeight: 100)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor(white: 1.0, alpha: 0.7))))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.3), lineWidth: 1)
                    )



                HStack {
                    Spacer()

                    Button(action: {
                        self.showCaptureImageView.toggle()
                    }) {
                        Image(systemName: (image==nil ? "photo.fill" : "xmark"))
                            .font(.system(size: 24))
                            .foregroundColor(Color("ColorMeta"))
                    }
                }.padding(.top, 10)
                    .padding(.trailing, 10)
                

            
                image?.resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 1))
                    .shadow(radius: 2, x: 0.5, y: 2.5)


                Button(action: {
                    var imageuuid: String? = nil
                    if(self.imageURL != "") {
                        imageuuid = UUID().uuidString
                        self.mainViewModel.uploadImage(imageURL: self.imageURL, uuid: imageuuid!)
                    }
                    
                    self.mainViewModel.makePost(imageuuid: imageuuid, reply_to: nil, contents: self.content, subject: nil) { success in
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
            .padding(.horizontal, 30)
        
            VStack {
                Spinner(items: mainViewModel.subjects)
                    .padding(.top, 20)
                Spacer()

            }
            
            if (showCaptureImageView) {
                CaptureImageView(isShown: $showCaptureImageView, image: $image, imageURL: $imageURL)
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
