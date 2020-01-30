//
//  Profile.swift
//  Squash
//
//  Created by Cory Kacal on 1/30/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI

struct Profile: View {
    @ObservedObject var mainViewModel: MainViewModel
    
    
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("My Posts")
                    Image(systemName: "chevron.right")
                }
            }
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: 100, alignment: .center)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
            ).background(RoundedRectangle(cornerRadius: 10).fill(Color("ColorPost"))
                .shadow(radius: 2, x: 0.5, y: 2.5))
        
            VStack {
                HStack {
                    Text("My Posts")
                    Image(systemName: "chevron.right")
                }
            }
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: 100, alignment: .center)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
            ).background(RoundedRectangle(cornerRadius: 10).fill(Color("ColorPost"))
                .shadow(radius: 2, x: 0.5, y: 2.5))
            
            VStack {
                HStack {
                    Text("My Posts")
                    Image(systemName: "chevron.right")
                }
            }
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: 100, alignment: .center)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
            ).background(RoundedRectangle(cornerRadius: 10).fill(Color("ColorPost"))
                .shadow(radius: 2, x: 0.5, y: 2.5))

            
            Spacer()
        }
        .padding(.top, 60)
        .padding(.horizontal, 10)
    .background(Image("Background"))
        
    }
}


/*
struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
 */
