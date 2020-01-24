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


struct PostRow: View {
    let post: Post
    let fullImage: Bool
    
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
        //Entire post stack
        VStack(spacing: 10) {
            
            //HStack to move content to the left using the trailing Spacer()
            HStack {
                //VStack to stack the subject ontop of the contents
                VStack(alignment: .leading) {
                    if self.post.subject != nil {
                        //ZStack to place the subject ontop of the rectangle
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .size(width: 1000, height: 17)
                                .fill(Color.yellow)
                                .padding(.horizontal, -20)
                                .padding(.top, -5)
                            //post subject
                            Text(self.post.subject!.uppercased())
                                .bold()
                                .font(.system(size: 13))
                                .padding(.top, -5)
                                .foregroundColor(Color.white)
                        }.padding(.bottom, -7)
                    }

                    //post contents
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
            
                        
            //Image attatched to the post
            if self.post.imageuuid != nil {
                //display full image for single post or not
                if(fullImage) {
                    FirebaseImage(id: self.post.imageuuid!)
                        .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    .padding([.horizontal], 20)
                } else {
                    FirebaseImage(id: self.post.imageuuid!)
                        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 130, idealHeight: 130, maxHeight:   200, alignment: .center)
                        .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    .padding([.horizontal], 20)
                }
            }
            


            //HStack to move the timestamp and comment count to the left using the trailing Spacer()
            HStack {
                Text(getTimeSince(date: self.post.timestamp))
                    .font(.system(size: 13))
                    .padding(.bottom, 5)
                    .padding(.horizontal, 7)
                
                if self.post.commentCount != nil {
                    Text(String(self.post.commentCount!))
                        .font(.system(size: 13))
                        .padding(.bottom, 5)
                }
                
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
            , timestamp: Date(), imageuuid: "43"), fullImage: false)
    }
}
#endif
