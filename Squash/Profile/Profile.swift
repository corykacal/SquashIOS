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
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        VStack {
                            Text("Up Votes!")
                                .font(.system(size: 30))

                            Text(String(self.mainViewModel.userData.totalUp))
                                .foregroundColor(Color.green)
                                .font(.system(size: 40, weight: .medium))
                        }
                        Spacer()
                        VStack {
                            Text("Down Votes")
                                .font(.system(size: 30))

                            Text(String(self.mainViewModel.userData.totalDown))
                                .foregroundColor(Color.red)
                                .font(.system(size: 40, weight: .medium))
                        }
                    }.padding(.horizontal, 20)
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
                        VStack(alignment: .leading) {
                            Text("total points:")
                                .font(.system(size: 20))
                            Text("post created:")
                            .font(.system(size: 20))

                            Text("comments made:")
                            .font(.system(size: 20))

                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(String(self.mainViewModel.userData.totalUp - self.mainViewModel.userData.totalDown))
                            .font(.system(size: 20))

                            Text(String(self.mainViewModel.userData.totalPosts))
                            .font(.system(size: 20))

                            Text(String(self.mainViewModel.userData.totalComments))
                            .font(.system(size: 20))

                        }
                    }.padding(.horizontal, 20)
                }
                .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: 100, alignment: .center)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                ).background(RoundedRectangle(cornerRadius: 10).fill(Color("ColorPost"))
                    .shadow(radius: 2, x: 0.5, y: 2.5))
                    .padding(.top, 13)
                NavigationLink(destination: UserPosts(mainViewModel: self.mainViewModel)) {
                    VStack {
                            HStack {
                                Text("My Posts")
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 32, weight: .medium))
                                    .foregroundColor(Color("ColorMeta"))

                            }.padding(.horizontal, 25)

                    }
                    .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: 100, alignment: .center)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                    ).background(RoundedRectangle(cornerRadius: 10).fill(Color("ColorPost"))
                        .shadow(radius: 2, x: 0.5, y: 2.5))
                }.buttonStyle(PlainButtonStyle())

                
                Spacer()
            }
            .padding(.top, 10)
            .padding(.horizontal, 10)
        .background(Image("Background"))
            
                .background(NavigationConfigurator { nc in
                    nc.navigationBar.barTintColor = UIColor.systemYellow
                 })
            .navigationBarItems(trailing:
            HStack {
                Button(action: {}) {
                    Image(systemName: "plus.square.fill")
                        .font(.largeTitle)
                }.foregroundColor(.blue)
            })
                // 5.
                .navigationBarTitle(Text("User Profile"), displayMode: .inline)

                .onAppear(perform: updateUser)
            
        }
        
    }
    
    private func updateUser() {
        self.mainViewModel.fetchUserData()
    }
}


/*
struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
 */
