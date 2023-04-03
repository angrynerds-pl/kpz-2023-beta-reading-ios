//
//  LoginView.swift
//  BetaReading
//
//  Created by Julia Gościniak on 02/04/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State var showPassword: Bool = false
    
    var body: some View {
        ZStack {
            Color(red: 67/255, green: 146/255, blue: 138/255).ignoresSafeArea()
            VStack {
                Image("AngryReaders")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 299)
                    .aspectRatio(contentMode: .fit)
                
                TextField("Username", text: $username)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongUsername))
                    .padding()
                HStack{
                    if showPassword{
                        SecureField("Password", text: $password)
                    }else {
                        TextField(password, text: $password)
                    }
                }
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongPassword))
                    .overlay(alignment: .trailing){
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .padding()
                        .onTapGesture {
                            showPassword.toggle()
                        }
                }
            
            HStack{
                Text("don't have an account?")
                    .foregroundColor(.white)
                Button("sign up"){}
                    .foregroundColor(Color(red: 254/255, green: 144/255, blue: 42/255))
            }
            Button("Forgot your password?"){}
                .foregroundColor(Color(red: 217/255, green: 217/255, blue: 217/255))
                .underline()
                .padding()
            Button("Login"){}
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 120, height: 50)
                    .background(Color(red: 254/255, green: 144/255, blue: 42/255))
                    .cornerRadius(20)
                }
            }
        }
    }

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
