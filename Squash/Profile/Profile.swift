//
//  Profile.swift
//  Squash
//
//  Created by Cory Kacal on 1/29/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI

struct Profile: View {
    @ObservedObject var mainViewModel: MainViewModel
    
    var body: some View {
        VStack {
            
            HStack {
                Text("My Post")
                Image(systemName: "chevron.right")
            }
            
            
        }.cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        ).background(RoundedRectangle(cornerRadius: 10).fill(Color("ColorPost"))
            .shadow(radius: 2, x: 0.5, y: 2.5))

    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
