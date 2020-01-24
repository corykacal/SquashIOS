//
//  CommentRow.swift
//  Squash
//
//  Created by Cory Kacal on 1/21/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI



struct CommentRow: View {
    let post: Post
    
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
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(post.contents)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                .layoutPriority(100)

                Spacer()
            }
            .padding()
        
            //HStack to move the timestamp and comment count to the left using the trailing Spacer()
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
        .padding([.top, .horizontal])
        
       
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
