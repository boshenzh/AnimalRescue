//
//  LoginView.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/5/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct LoginView : View {
    
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    
    @State private var enteredPassword = ""
    @State private var showInvalidPasswordAlert = false
    @State private var showInvalidFaceAlert = false
    
    @State private var showForgetPass = false
    
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Image("Welcome")
                            .padding(.top, 30)
                        
                        Text("Animal Rescue Information Manager")
                            .font(.headline)
                            .padding()
                        
                        Image("2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 300, maxWidth: 600)
                            .padding()
                        
                        SecureField("Password", text: $enteredPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 300, height: 36)
                            .padding()
                        HStack{
                            Spacer()
                            Button(action: {
                                /*
                                 UserDefaults provides an interface to the user’s defaults database,
                                 where you store key-value pairs persistently across launches of your app.
                                 */
                                // Retrieve the password from the user’s defaults database under the key "Password"
                                let validPassword = UserDefaults.standard.string(forKey: "Password")
                                /*
                                 If the user has not yet set a password, validPassword = nil
                                 In this case, allow the user to login.
                                 */
                                
                                if validPassword == nil || self.enteredPassword == validPassword {
                                    
                                    
                                    userData.userAuthenticated = true
                                    self.showInvalidPasswordAlert = false
                                } else {
                                    self.showInvalidPasswordAlert = true
                                }
                                
                            }) {
                                Text("Login")
                                    .frame(width: 100, height: 36, alignment: .center)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .strokeBorder(Color.black, lineWidth: 1)
                                    )
                                    .padding()
                                
                                
                            }
                            .alert(isPresented: $showInvalidPasswordAlert, content: { self.invalidPasswordAlert })
                            //                        Button(action: {
                            //                            authenticate()
                            //                            if self.isUnlocked {
                            //                                userData.userAuthenticated = true
                            //                              //  self.showInvalidFaceAlert = false
                            //                            } else {
                            //                       //        self.showInvalidFaceAlert = true
                            //                            }
                            //
                            //                        }) {
                            //                            Text("Face ID")
                            //                                .frame(width: 100, height: 36, alignment: .center)
                            //                                .background(
                            //                                    RoundedRectangle(cornerRadius: 16)
                            //                                        .strokeBorder(Color.black, lineWidth: 1)
                            //                                )
                            //                                .padding()
                            //
                            //
                            //                        }
                            //                       // .alert(isPresented: $showInvalidFaceAlert, content: { self.invalidFaceAlert })
                            
                            Spacer()
                            let validPassword = UserDefaults.standard.string(forKey: "Password")
                            
                            if validPassword != nil{
                                NavigationLink(destination: ResetPassword()) {
                                    HStack {
                                        Text("Forgot Password")
                                            .frame(width: 200, height: 36, alignment: .center)
                                            .background(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .strokeBorder(Color.black, lineWidth: 1))
                                            .foregroundColor(.blue)
                                    }
                                    
                                }
                                
                                
                                .alert(isPresented: $showInvalidPasswordAlert, content: { self.invalidPasswordAlert })
                                
                            }
                        }
                        
                    }
                    // End of VStack
                }   // End of ScrollView
            }   // End of ZStack
        }//end of navi
        .navigationTitle("Password Reset")
    }   // End of var
    
    /*
     ------------------------------
     MARK: - Invalid Password Alert
     ------------------------------
     */
    var invalidPasswordAlert: Alert {
        Alert(title: Text("Invalid Password!"),
              message: Text("Please enter a valid password to unlock the app!"),
              dismissButton: .default(Text("OK")) )
        // Tapping OK resets @State var showInvalidPasswordAlert to false.
    }
    var invalidFaceAlert: Alert {
        Alert(title: Text("Face Not Match!"),
              message: Text("Please Try Again!"),
              dismissButton: .default(Text("OK")) )
        // Tapping OK resets @State var showInvalidPasswordAlert to false.
    }
    
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

