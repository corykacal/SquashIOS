//
//  FullScreen.swift
//  Squash
//
//  Created by Cory Kacal on 1/21/20.
//  Copyright © 2020 Cory Kacal. All rights reserved.
//

import SwiftUI

struct FullScreen: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    
    var body: some View {
        Text("FullScreen")
            .edgesIgnoringSafeArea(.all)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(Color.red)
            .onTapGesture {
                self.mainViewModel.showFullScreen.toggle()
        }
    }
}

struct FullScreen_Previews: PreviewProvider {
    static var previews: some View {
        FullScreen()
    }
}
