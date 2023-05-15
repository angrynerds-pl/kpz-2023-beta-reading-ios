//
//  ResetPasswordView.swift
//  BetaReading
//
//  Created by Julia Gościniak on 14/05/2023.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var email = ""
    @State private var wrongUsername = 0
    @State private var showingLoginScreen = false
    
    //@StateObject private var vm = SignUpViewModel()
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        ZStack {
            Color(red: 67/255, green: 146/255, blue: 138/255).ignoresSafeArea()
            VStack {
                Image("AngryReaders")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 299)
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
                Text("Enter your email to reset your password")
                
                TextField("Email", text: $email)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongUsername))
                    .padding()
                
                Spacer()
                
                Button(action: {
                    guard !email.isEmpty else{
                        return
                    }
                    authViewModel.resetPassword(email: email)
                }, label: {
                    Text("Reset")
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 120, height: 50)
                    .background(Color(red: 254/255, green: 144/255, blue: 42/255))
                    .cornerRadius(20)
                })
            
//            Button("Sign up"){
//
//                vm.signUp(email: email, password: password ){ result in
//                    switch result {
//                        case.success(_):
//                            print("Take the user to login screen")          //TO DO
//                        case.failure(let error):
//                            vm.errorMessage = error.errorMessage
//                    }
//
//                }
//            }
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 120, height: 50)
                    .background(Color(red: 254/255, green: 144/255, blue: 42/255))
                    .cornerRadius(20)
                
//                if let errorMessage = vm.errorMessage {
//                    Text(errorMessage)
//                }
            }
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
