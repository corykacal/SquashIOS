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
            TabView(selection: $selection){
                PostsList(mainViewModel: mainViewModel)
                    .tabItem {
                        VStack {
                            Image("first")
                            Text("Posts")
                        }
                    }
                    .tag(0)
                //.edgesIgnoringSafeArea(.all)
                Text("Profile")
                    .font(.title)
                    .tabItem {
                        VStack {
                            Image("second")
                            Text("Profile")
                        }
                    }
                    .tag(1)
        
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

