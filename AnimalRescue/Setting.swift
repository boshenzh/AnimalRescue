//
//  Setings.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/5/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI

struct Setting: View {
    @State private var showEnteredValues = false

    @State private var answerEntered = ""
    @State private var passwordEntered = ""
    @State private var passwordVerified = ""
    @State private var showUnmatchedPasswordAlert = false
    @State private var showPasswordSetAlert = false
    @State private var selectedIndex = 0

    let listOfAllquestions = ["In what city or town did your mother and father meet?", "In what city or town were you born?","what did you want to be when you grew up?","what do you remeber from your childhood?","what is the name of the boy or girl that you first kissed","What is the name of the first school you attended?","What is the name of the favorite childhood friend?", "what is the name of your first pet?","what is your mother's maiden name?", "what was your favorite place to visit as a child?"]
    
    var body: some View {
        NavigationView{
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            
            Form {
                Section(header: Text("Show/hide entered values")) {
                    Toggle(isOn: $showEnteredValues){
                        Text("Show Entered Values")
                    }
                }
                Section(header: Text("Select a security question")) {
                    Picker("Selected:", selection: $selectedIndex) {
                        ForEach(0 ..< listOfAllquestions.count, id: \.self) {
                            Text(listOfAllquestions[$0])
                        }
                    }
                    .frame(minWidth: 300, maxWidth: 500,alignment: .center)
                    
                }

                if self.showEnteredValues {
                    
                    Section(header:Text("Enter answer to selected security question")){
                        HStack{
                            TextField("Enter Answer", text: $answerEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 280, height:20)
                                .padding()
                                .autocapitalization(.none)

                                
                                
                            Button(action: {
                                self.answerEntered = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                        }
                    }
                    
                    
                } else {
                    
                    Section(header:Text("Enter answer to selected security question"))
                    {
                        HStack{
                            SecureField("Enter Answer", text: $answerEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 280, height: 20)
                                .padding()
                            Button(action: {
                                self.answerEntered = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                            
                        }
                    }
                }
                if self.showEnteredValues {
                    
                    Section(header:Text("Enter Password")){
                        HStack{
                            TextField("Enter Password", text: $passwordEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 280, height:20)
                                .padding()
                                .autocapitalization(.none)

                            Button(action: {
                                self.passwordEntered = ""
                                self.passwordVerified = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                        }
                    }
                    
                    
                } else {
                    
                    Section(header:Text("Enter Password"))
                    {
                        HStack{
                            SecureField("Enter Password", text: $passwordEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 280, height:20)
                                .padding()
                            Button(action: {
                                self.passwordEntered = ""
                                self.passwordVerified = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                            
                        }
                    }
                }
                if self.showEnteredValues {
                    
                    Section(header:Text("Verify Password")){
                        HStack{
                            TextField("Verify Password", text: $passwordVerified)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 280, height:20)
                                .padding()
                                .autocapitalization(.none)
                            Button(action: {
                                self.passwordVerified = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                        }
                    }
                    
                } else {
                    
                    Section(header:Text("Verify Password"))
                    {
                        HStack{
                            SecureField("Verify Password", text: $passwordVerified)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 280, height:20)
                                .padding()
                            Button(action: {
                                self.passwordVerified = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                            
                        }
                    }
                }
                Section(header:Text("set password")){
                    Button(action: {
                        if !passwordEntered.isEmpty {
                            if passwordEntered == passwordVerified {
                                /*
                                 UserDefaults provides an interface to the user’s defaults database,
                                 where you store key-value pairs persistently across launches of your app.
                                 */
                                // Store the password in the user’s defaults database under the key "Password"
                                UserDefaults.standard.set(self.passwordEntered, forKey: "Password")
                                UserDefaults.standard.set(listOfAllquestions[selectedIndex], forKey: "Question")
                                UserDefaults.standard.set(self.answerEntered, forKey: "Answer")


                                self.answerEntered = ""
                                self.passwordEntered = ""
                                self.passwordVerified = ""
                                self.showPasswordSetAlert = true
                            } else {
                                self.showUnmatchedPasswordAlert = true
                            }
                        }
                    }) {
                        Text("Set Password to Unlock App")
                            .frame(width: 300, height: 36, alignment: .center)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.black, lineWidth: 1)
                            )
                    }
                    .alert(isPresented: $showUnmatchedPasswordAlert, content: { self.unmatchedPasswordAlert })
                    .alert(isPresented: $showPasswordSetAlert, content: { self.passwordSetAlert })
                }
                                
            }   // End of VStack
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
            .font(.system(size: 14))
            
        }   // End of ZStack
        }//end of navigation
    }   // End of var
    
    /*
     --------------------------
     MARK: - Password Set Alert
     --------------------------
     */
    var passwordSetAlert: Alert {
        Alert(title: Text("Password Set!"),
              message: Text("Password you entered is set to unlock the app!"),
              dismissButton: .default(Text("OK")) )
    }
    
    /*
     --------------------------------
     MARK: - Unmatched Password Alert
     --------------------------------
     */
    var unmatchedPasswordAlert: Alert {
        Alert(title: Text("Unmatched Password!"),
              message: Text("Two entries of the password must match!"),
              dismissButton: .default(Text("OK")) )
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        Setting()
    }
}


