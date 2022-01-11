//
//  ResetPassword.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/5/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI

struct ResetPassword: View {
    @State private var showEnteredValues = false
    @State private var showUnmatchedPasswordAlert = false
    
    @State private var answerEntered = ""
    /* @State private var passwordEntered = ""
     @State private var passwordVerified = ""
     @State private var showPasswordSetAlert = false
     @State private var selectedIndexFrom = 0
     */
    var listOfAllquestions = ["In what city or town did your mother and father meet?", "In what city or town were you born?","what did you want to be when you grew up?","what do you remeber from your childhood?","what is the name of the boy or girl that you first kissed","What is the name of the first school you attended?","What is the name of the favorite childhood friend?", "what is the name of your first pet?","what is your mother's maiden name?", "what was your favorite place to visit as a child?"]
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            Form {
                Section(header: Text("Show/hide entered values")) {
                    Toggle(isOn: $showEnteredValues){
                        Text("Show Entered Values")
                    }
                }
                
                Section(header:Text("Security Question")){
                    let question = UserDefaults.standard.string(forKey: "Question")
                    Text("\(question ?? "")")
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 280, height:40)
                        .padding()
                        .font(.system(size:14))
                }
                if self.showEnteredValues {
                    
                    Section(header:Text("Enter Answer")){
                        HStack{
                            
                            TextField("Enter Answer", text: $answerEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 250, height:20)
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
                    
                    
                } else {
                    
                    Section(header:Text("Enter Answer"))
                    {
                        HStack{
                            SecureField("Enter Answer", text: $answerEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 250, height: 20)
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
                if !answerEntered.isEmpty {
                    let answerReal = UserDefaults.standard.string(forKey: "Answer")
                    
                    if answerEntered ==  answerReal {
                        Section(header:Text("go to settings to reset password")){
                            NavigationLink(
                                destination: Setting()){
                                HStack{
                                    Image(systemName: "gear")
                                        .foregroundColor(.blue)
                                    Text("Show Setings")
                                }
                            }
                        }
                    } else {
                        Section(header: Text("Incorrect answer")) {
                            Text("Answer to security question is incorrect")
                        }
                    }
                    
                }
            }
            .navigationBarTitle(Text("Password Reset"), displayMode: .inline)
            .font(.system(size: 14))
            .padding()
            
    }   // End of ZStack
    

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

struct ResetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ResetPassword()
    }
}


