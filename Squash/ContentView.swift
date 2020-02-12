//
//  ContentView.swift
//  Squash
//
//  Created by Cory Kacal on 1/12/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI
import Foundation
import CoreLocation
import Combine

struct ContentView: View {
    @State private var selection = 0
    
    @ObservedObject var mainViewModel: MainViewModel

    
    @ObservedObject var locationManager: LocationManager

    
 
    var body: some View {

        ZStack {
            if(locationManager.statusString != "authorizedWhenInUse") {
                GetUserLocation()
            } else if (locationManager.lastLocation == nil || locationManager.lastLocation?.coordinate == nil) {
                Color.white
                .onAppear(perform: {
                    self.locationManager.startUpdating()
                })
            } else {
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
                .onAppear(perform: {                    
                    self.mainViewModel.fetchPosts(number_of_posts: 20, page_number: 1) { success in
                    
                    }
                    self.mainViewModel.fetchHotPosts(number_of_posts: 20, page_number: 1) { success in
                    }

                    self.mainViewModel.fetchSubjects()
                    self.mainViewModel.fetchUserData()
                })
            

        }
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

