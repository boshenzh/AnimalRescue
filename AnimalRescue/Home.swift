//
//  Home.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/1/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI

struct Home: View {
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    Text("Animal Rescue")
                        .font(.custom("Helvetica Neue", size: 30))
                        .padding(.top, 100)
                    
                    Image("\(userData.imageNumber + 1)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 400, maxWidth: 400, minHeight: 300, maxHeight: 300, alignment: .center)
                        .padding()
                    
                    HStack {
                        Button(action: {    // Button 1
                            self.userData.imageNumber = 0
                        }) {
                            self.imageForButton(buttonNumber: 0)
                        }
                        Button(action: {    // Button 2
                            self.userData.imageNumber = 1
                        }) {
                            self.imageForButton(buttonNumber: 1)
                        }
                        Button(action: {    // Button 3
                            self.userData.imageNumber = 2
                        }) {
                            self.imageForButton(buttonNumber: 2)
                        }
                        Button(action: {    // Button 4
                            self.userData.imageNumber = 3
                        }) {
                            self.imageForButton(buttonNumber: 3)
                        }
                        Button(action: {    // Button 5
                            self.userData.imageNumber = 4
                        }) {
                            self.imageForButton(buttonNumber: 4)
                        }
                        Button(action: {    // Button 6
                            self.userData.imageNumber = 5
                        }) {
                            self.imageForButton(buttonNumber: 5)
                        }
                        Button(action: {    // Button 7
                            self.userData.imageNumber = 6
                        }) {
                            self.imageForButton(buttonNumber: 6)
                        }
                        Button(action: {    // Button 8
                            self.userData.imageNumber = 7
                        }) {
                            self.imageForButton(buttonNumber: 7)
                        }
                        Button(action: {    // Button 9
                            self.userData.imageNumber = 8
                        }) {
                            self.imageForButton(buttonNumber: 8)
                        }
                        
                    }   // End of HStack
                    .imageScale(.medium)
                    .font(Font.title.weight(.regular))
                    .padding(.bottom, 50)
                    
                    Text("Powered By:")
                        .padding(.bottom, 10)
                    
                    // Show Rescue Group's website in default web browser
                    Link(destination: URL(string: "https://cat-fact.herokuapp.com/#/")!) {
                        HStack {
                            Image(systemName: "gearshape.2")
                            Text("Cat Facts API")
                                .padding(.bottom, 10)
                        }
                    }
                    Link(destination: URL(string: "https://test1-api.rescuegroups.org/v5/public/docs")!) {
                        HStack {
                            Image(systemName: "gearshape.2")
                            Text("RescueGroup API")
                        }
                    }
                    
                    
                }   // End of VStack
                
            }   // End of ScrollView
            .onAppear() {
                self.userData.startTimer()
            }
            .onDisappear() {
                self.userData.stopTimer()
            }
            
        }   // End of ZStack
    }
    
    func imageForButton(buttonNumber: Int) -> Image {
        
        if self.userData.imageNumber == buttonNumber {
            return Image(systemName: "\(buttonNumber+1).circle.fill")
        } else {
            return Image(systemName: "\(buttonNumber+1).circle")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
