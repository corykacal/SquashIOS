//
//  ContentView.swift
//  Squash
//
//  Created by Cory Kacal on 1/12/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    @ObservedObject var mainViewModel: MainViewModel

    
    
 
    var body: some View {
        ZStack {
            
            Color.yellow
                .edgesIgnoringSafeArea(.all)
            
            Color("ColorBackground")
            
            TabView(selection: $selection){
                PostsList(mainViewModel: mainViewModel)
                    .tabItem {
                        VStack {
                            Image(systemName: "text.bubble")
                            Text("Posts")
                        }
                    }
                    .tag(0)
                //.edgesIgnoringSafeArea(.all)
                Profile(mainViewModel: mainViewModel)
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image(systemName: "person.crop.circle")
                            Text("Profile")
                        }
                    }
                    .tag(1)
        
            }.foregroundColor(Color.black)
                .accentColor(Color.black)
        }
    }
}

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/

