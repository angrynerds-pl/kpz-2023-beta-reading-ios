//
//  SignInView.swift
//  BetaReading
//
//  Created by Julia Gościniak on 11/05/2023.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State var showPassword: Bool = false
    
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
                
                TextField("Email", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongUsername))
                    .padding()
                HStack{
                    if showPassword{
                        TextField(password, text: $password)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                    }else {
                        SecureField("Password", text: $password)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                    
                }
                .padding()
                .frame(width: 300, height: 50)
                .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                .cornerRadius(10)
                .border(.red, width: CGFloat(wrongPassword))
                .overlay(alignment: .trailing){
                    Image(systemName: showPassword ? "eye" : "eye.slash")
                        .padding()
                        .onTapGesture {
                            showPassword.toggle()
                        }
                }
                
                HStack{
                    Text("don't have an account?")
                        .foregroundColor(.white)
                    NavigationLink("sign up", destination: SignUpView()
                        .environmentObject(authViewModel))
                    .foregroundColor(Color(red: 254/255, green: 144/255, blue: 42/255))
                }
                NavigationLink("Forgot your password?", destination: ResetPasswordView()
                    .environmentObject(authViewModel))
                .foregroundColor(Color(red: 217/255, green: 217/255, blue: 217/255))
                .underline()
                .padding()
                if authViewModel.errorOccurred {
                    Text(authViewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty else{
                        return
                    }
                    authViewModel.signIn(email: email, password: password)
                }, label: {
                    Text("Sign In")
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 120, height: 50)
                        .background(Color(red: 254/255, green: 144/255, blue: 42/255))
                        .cornerRadius(20)
                })
            }
        }
        .onAppear {
            email = ""
            password = ""
            authViewModel.errorOccurred = false
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
