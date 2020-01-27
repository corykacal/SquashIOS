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
    let cropped: Bool
        
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
        
        HStack {
            //Entire post stack
            VStack(spacing: 10) {
                //HStack to move content to the left using the trailing Spacer()
                HStack {
                    //VStack to stack the subject ontop of the contents
                    VStack(alignment: .leading, spacing: 0) {
                        ZStack(alignment: .leading) {

                        if self.post.subject != nil {
                            //ZStack to place the subject ontop of the rectangle
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
                            }
                        }

                        
                        
                        //post contents
                        Text(self.post.contents)
                            .font(.system(size: 20))
                            .foregroundColor(.primary)
                            .padding(.top, 3.5)
                    }
                    .layoutPriority(100)

                    Spacer()
                    
                }
                .padding(.top, 5)
                .padding(.horizontal, 6)
                .padding(.leading, 3)
                            
                //Image attatched to the post
                if self.post.imageuuid != nil {
                    //display full image for single post or not
                    if self.cropped {
                        FirebaseImage(id: self.post.imageuuid!)
                            .frame(minWidth: 0, idealWidth: 200, maxWidth: .infinity, minHeight: 130, idealHeight: 130, maxHeight:   200, alignment: .center)
                            .clipShape(
                            RoundedRectangle(cornerRadius: 10)
                        )        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.2), lineWidth: 1)
                        )
                        .padding([.horizontal], 20)
                    } else {
                        FirebaseImage(id: self.post.imageuuid!)
                            
                            .clipShape(
                            RoundedRectangle(cornerRadius: 10)
                        )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.2), lineWidth: 1)
                            )
                        .padding([.horizontal], 20)
                    }
                }

                Spacer()
                //HStack to move the timestamp and comment count to the left using the trailing Spacer()
                HStack {
                    Text(getTimeSince(date: self.post.timestamp))
                        .font(.system(size: 13))
                        .padding(.bottom, 5)
                        .padding(.leading, 7)
                        .opacity(0.3)
                    
                    Image(systemName: "text.bubble.fill")
                        .font(.system(size: 12.0, weight: .bold))
                        .foregroundColor(Color.black)
                        .opacity(0.2)
                        .padding(.bottom, 3)
                        .padding(.trailing, -4)

                    if self.post.commentCount != nil {
                        Text(String(self.post.commentCount!))
                            .font(.system(size: 13))
                            .padding(.bottom, 5)
                            .opacity(0.3)
                    }
                    
                    Spacer()
                }
            }
            
            
            VStack {
                Image(systemName: "chevron.up")
                    .font(.system(size: 29, weight: .medium))
                    .foregroundColor(Color.black)
                    .opacity(0.2)
                    .padding(.top, 15)
                    .onTapGesture {
                        print("upvote")
                    }
                Spacer()
                Text(String(self.post.points))
                    .foregroundColor((self.post.points<0) ? Color.red : Color.green)
                    .padding(.trailing, 1)
                Spacer()
                Image(systemName: "chevron.down")
                    .font(.system(size: 29, weight: .medium))
                    .foregroundColor(Color.black)
                    .opacity(0.2)
                    .padding(.bottom, 6)
                    .onTapGesture {
                        print("downvote")
                    }
            }.padding(.trailing, 8)
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        ).background(RoundedRectangle(cornerRadius: 10).fill(Color.white)
            .shadow(radius: 2, x: 0.5, y: 2.5))
            .padding([.top, .horizontal], 5)
            .padding(.horizontal, 5)
    }
}


#if DEBUG
struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(post: Post(contents: "test post", id: 1, timestamp: Date(), subject: "test", imageuuid: "43", points: 4), cropped: true)
    }
}
#endif
