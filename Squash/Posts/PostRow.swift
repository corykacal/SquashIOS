//
//  PostRow.swift
//  Squash
//
//  Created by Cory Kacal on 1/12/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI


/*
 let placeholder = UIImage(named: "placeholder.jpg")!

 struct FirebaseImage : View {

     init(id: String) {
         self.imageLoader = Loader(id)
     }

     @ObjectBinding private var imageLoader : Loader

     var image: UIImage? {
         imageLoader.data.flatMap(UIImage.init)
     }

     var body: some View {
         Image(uiImage: image ?? placeholder)
     }
 }
 */

let placeholder = UIImage(systemName: "photo.fill")!

struct PostRow: View {
    
    init(post: Post) {
        self.post = post
        self.photoLoader = PhotoLoader(post.imageuuid)
    }
    
    let post: Post
    
    @ObservedObject private var photoLoader: PhotoLoader
    
    var image: UIImage? {
        photoLoader.data.flatMap(UIImage.init)
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    self.post.subject.map({
                        Text($0)
                    })
                    

                    Text(self.post.contents)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                .layoutPriority(100)

                Spacer()
            }
            .padding()
            
            self.post.imageuuid.map({_ in
                Image(uiImage: image ?? placeholder)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)

                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.9), lineWidth: 1)
                ).background(RoundedRectangle(cornerRadius: 10).fill(Color.white))

            })



            
        
            HStack {
                Text(String(self.post.id))
                
                Spacer()
            }
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.9), lineWidth: 1)
        ).background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .padding([.top, .horizontal], 5)
        
       
    }
}


/*
#if DEBUG
struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(post: Post(contents: "test post", id: 1, comment_count: 10))
    }
}
#endif
*/
