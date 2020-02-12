//
//  GetUserLocation.swift
//  Squash
//
//  Created by Cory Kacal on 2/11/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI
import CoreLocation

struct GetUserLocation: View {
    @ObservedObject var locationManager = LocationManager()

    var body: some View {
        Text("get location").onTapGesture {
            self.locationManager.requestLocation()
        }
    }
}

/*
 
struct GetUserLocation_Previews: PreviewProvider {
    static var previews: some View {
        GetUserLocation()
    }
}
 */
