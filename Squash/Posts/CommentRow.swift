//
//  CommentRow.swift
//  Squash
//
//  Created by Cory Kacal on 1/21/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI
import URLImage



struct CommentRow: View {
    let post: Post
        
    @ObservedObject var mainViewModel: MainViewModel
    
    @State var decision: Bool? = nil
    
    @State var up: Int = 0
    @State var down: Int = 0

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
                        
            VStack(alignment: .center) {
                ZStack {
                    if self.post.veggie_color != nil {
                        Circle()
                            .foregroundColor(Color(rgbValue: post.veggie_color!))
                            .frame(width: 25, height: 25)
                    }
                    
                    if self.post.veggie_url != nil {
                        URLImage(URL(string: post.veggie_url!)!,
                            processors: [ Resize(size: CGSize(width: 100.0, height: 100.0), scale: UIScreen.main.scale) ],
                            placeholder: Image(systemName: "circle"),
                            content:  {
                                $0.image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                            })
                            .frame(width: 25, height: 25)
                    }
                }
                
                
                Spacer()
            }.padding(.top, 5)
                        
           VStack(alignment: .leading) {
                  
               if !(self.post.subject==nil) {
                   Text(self.post.subject!.uppercased())
                       .background(Rectangle()
                           .foregroundColor((self.post.subject=="STICKY") ? Color.blue : (Color(rgbValue: self.post.color ?? 16763904)))
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
                                          
                       HStack {
                           Text(getTimeSince(date: self.post.timestamp))
                               .font(.system(size: 13))
                               .padding(.bottom, 5)
                               .padding(.leading, 7)
                               .foregroundColor(Color("ColorMeta"))
                           
                           Spacer()
                       }
                   }
                   
                   VStack(alignment: .center) {
                       Spacer()
                       Image(systemName: "chevron.up")
                           .font(.system(size: 32, weight: .medium))
                           .opacity(0.6)
                           .foregroundColor(self.decision==true ? Color.green : Color("ColorMeta"))
                           .onTapGesture {
                                if(self.decision==true) {
                                   self.decision = nil
                                    self.up -= 1
                                   self.mainViewModel.makeDecision(decision: nil, post_number: self.post.id)
                               } else {
                                    if(self.decision==false) {
                                        self.down-=1
                                        self.up+=1
                                    } else {
                                        self.up+=1
                                    }
                                   self.decision = true
                                
                                   self.mainViewModel.makeDecision(decision: true, post_number: self.post.id)
                               }
                           }
                       Text(String((self.up - self.down)))
                           .foregroundColor(((self.up - self.down)<0) ? Color.red : Color.green)
                           .padding(.trailing, 1)
                       Image(systemName: "chevron.down")
                           .font(.system(size: 32, weight: .medium))
                           .opacity(0.6)
                           .foregroundColor(self.decision==false ? Color.red : Color("ColorMeta"))
                           .onTapGesture {

                               if(self.decision==false) {
                                   self.decision = nil
                                self.down-=1
                                   self.mainViewModel.makeDecision(decision: nil, post_number: self.post.id)
                               } else {
                                if(self.decision==true) {
                                    self.down+=1
                                    self.up-=1
                                } else {
                                    self.down+=1
                                }
                                   self.decision = false

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
           ).background(RoundedRectangle(cornerRadius: 10).fill((self.post.subject=="STICKY") ? Color("Sticky") : Color("ColorPost"))
               .shadow(radius: 2, x: 0.5, y: 2.5))
        
        .onAppear(perform: {
            self.decision = self.post.decision
            self.down = self.post.down
            self.up = self.post.up
        })

        }
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
