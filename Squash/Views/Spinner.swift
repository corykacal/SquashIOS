//
//  Spinner.swift
//  Squash
//
//  Created by Cory Kacal on 1/26/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI

struct Spinner: View {
    @State var expand = false
    @State var currentIndex = 0

    init(items: [Subject]) {
        self.items = items
    }
    
    var items: [Subject]

    var body: some View {
        VStack {

            HStack {
                Text(self.items[currentIndex].subject)
                    .fontWeight(.semibold)
                    .font(.system(size: 20))

                
                Image(systemName: expand ? "chevron.up" : "chevron.down").resizable().frame(width: 15, height: 10)
            }.onTapGesture {
                self.expand.toggle()
            }.padding(6)
            .padding([.horizontal], 3)
            
            if expand {
                VStack (spacing: 6.5) {
                    ForEach(0..<items.count) { index in
                        Button(action: {
                            self.currentIndex = index
                            self.expand.toggle()
                        }) {
                            VStack {
                                Divider().padding(.horizontal, 20)

                                Text(String(self.items[index].subject))
                                .fontWeight(.medium)
                                .font(.system(size: 20))
                            }

                        }.foregroundColor(.black)
                    }
                }.padding([.horizontal, .bottom], 7)
            
            }
        }
        .background(LinearGradient(gradient: .init(colors: [.orange, .yellow]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .padding(7)
        .animation(.spring())
        .padding(.horizontal, 60)
    }
}

/*
struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner()
    }
}
*/
