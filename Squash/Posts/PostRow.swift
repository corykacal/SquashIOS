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
    @Binding var post: Post
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
        
        VStack(alignment: .leading) {
               
            if !(self.post.subject==nil) {
                Text(self.post.subject!.uppercased())
                    .background(Rectangle()
                        .foregroundColor(Color.yellow)
                        .frame(width: 1000, height: 20, alignment: .center)
                    )
                    .foregroundColor(Color.white)
                    .font(.system(size: 12, weight: .bold))
                    .padding(.leading, 5)
                    .padding(.top, 2.5)
            }
            
            HStack(alignment: .top) {
                
                VStack(alignment: .leading) {
                    Text(post.contents)
                        .font(.system(size: 18))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                    
                    Spacer()
                    
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
                    
                    HStack {
                        Text(getTimeSince(date: self.post.timestamp))
                            .font(.system(size: 13))
                            .padding(.bottom, 5)
                            .padding(.leading, 7)
                            .foregroundColor(Color("ColorMeta"))

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
                                .foregroundColor(Color("ColorMeta"))
                        }
                        
                        Spacer()
                    }
                }
                
                VStack(alignment: .center) {
                    Spacer()
                    Image(systemName: "chevron.up")
                        .font(.system(size: 32, weight: .medium))
                        .foregroundColor(self.post.decision==true ? Color.green : Color("ColorMeta"))
                        .onTapGesture {
                            if(self.decision==true) {
                                self.post.decision = nil
                                self.mainViewModel.makeDecision(decision: nil, post_number: self.post.id)
                            } else {
                                self.post.decision = true

                                self.mainViewModel.makeDecision(decision: true, post_number: self.post.id)
                            }
                        }
                    Text(String(self.post.points))
                        .foregroundColor((self.post.points<0) ? Color.red : Color.green)
                        .padding(.trailing, 1)
                    Image(systemName: "chevron.down")
                        .font(.system(size: 32, weight: .medium))
                        .foregroundColor(self.post.decision==false ? Color.red : Color("ColorMeta"))
                        .onTapGesture {

                            if(self.decision==false) {
                                self.post.decision = nil
                                
                                self.mainViewModel.makeDecision(decision: nil, post_number: self.post.id)
                            } else {
                                self.post.decision = false

                                self.mainViewModel.makeDecision(decision: false, post_number: self.post.id)
                            }
                        }

                    Spacer()
                }
                Spacer()
                
            }

 

        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        ).background(RoundedRectangle(cornerRadius: 10).fill(Color("ColorPost"))
            .shadow(radius: 2, x: 0.5, y: 2.5))
    }
    
}

/*
#if DEBUG
struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(post: Post(contents: "test post", id: 1, timestamp: Date(), subject: "test", imageuuid: "43", points: 4), cropped: true)
    }
}
#endif
*/
