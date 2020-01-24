//
//  PostRow.swift
//  Squash
//
//  Created by Cory Kacal on 1/12/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI
import SwiftSVG
import UIKit


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


struct PostRow: View {
    let post: Post
    
    let svg = SVGView(SVGNamed: "Arrow-down")
    
    private func getTimeSince(date: Date) -> String {
        let seconds = Int(abs(date.timeIntervalSinceNow))
        let minutes = (seconds/60)
        let hours = (minutes/60)
        let days = (hours/24)
        let possibleTickers = [["d", days],  ["h", hours], ["m", minutes], ["s", seconds]]
        for pair in possibleTickers {
            let ticker = pair[0] as! String
            let value = pair[1] as! Int
            if(value>0) {
                return String(value) + " " + ticker
            }
        }
        return "0 s"
    }
    
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading) {
                    if self.post.subject != nil {
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .size(width: 1000, height: 17)
                                .fill(Color.yellow)
                                .padding(.horizontal, -20)
                                .padding(.top, -5)
                            Text(self.post.subject!.uppercased())
                                .bold()
                                .font(.system(size: 11))
                                .padding(.top, -5)
                                .foregroundColor(Color.white)
                        }.padding(.bottom, -7)
                    }

                    Text(self.post.contents)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .padding(.top, 3.5)
                }
                .layoutPriority(100)

                Spacer()
            }
            .padding(.top, 5)
            .padding(.horizontal, 6)
            
                        
            HStack {
                self.post.imageuuid.map({
                    FirebaseImage(id: $0)
                        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 60, idealHeight: 130, maxHeight: 200, alignment: .center)
                        .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    .padding([.horizontal], 20)

                })
            }


        
            HStack {
                Text(getTimeSince(date: self.post.timestamp))
                    .font(.system(size: 13))
                    .padding(.bottom, 5)
                    .padding(.horizontal, 7)
                
                
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


#if DEBUG
struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(post: Post(contents: "test post", id: 1
            , timestamp: Date(), imageuuid: "43"))
    }
}
#endif
