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
        
    @EnvironmentObject var mainViewModel: MainViewModel

    
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
    
    @State var decision: Bool? = nil
    
    var body: some View {
        
        VStack {
               
            if !(self.post.subject==nil) {
                ZStack {
                    Text(self.post.subject!)
                    Rectangle().foregroundColor(Color.yellow)
                }
            }
            
            HStack {
                
                VStack {
                    Text(post.contents)
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
                        
                        Text(getTimeSince(date: self.post.timestamp))
                    }
                }
                
                Spacer()
                VStack {
                    Image(systemName: "chevron.up")
                    Text(String(self.post.points))
                    Image(systemName: "chevron.down")
                }
                
            }

 

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
    
    private func setStates() {
        self.decision = self.post.decision
        print(self.post.contents)
        print(self.post.decision)
    }
}


#if DEBUG
struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(post: Post(contents: "test post", id: 1, timestamp: Date(), subject: "test", imageuuid: "43", points: 4), cropped: true)
    }
}
#endif
