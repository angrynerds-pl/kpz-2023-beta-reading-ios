//
//  SignUpView.swift
//  BetaReading
//
//  Created by Julia Gościniak on 09/05/2023.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var surname = ""
    @State private var repeatPassword = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State var showPassword: Bool = false
    
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
                
                TextField("Email", text: $email)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongUsername))
                    .padding()
                
                TextField("First Name", text: $name )
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(wrongUsername))
                    .padding()
                
                TextField("Last Name", text: $surname)
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
                    .padding()
                
                HStack{
                    if showPassword{
                        SecureField("Repeat Password", text: $repeatPassword)
                        
                    }else {
                        TextField(repeatPassword, text: $repeatPassword)
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
                    .padding()
                
                
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty, password == repeatPassword else {
                            return
                        }
                    authViewModel.signUp(email: email, password: password, name: name, surname: surname )
                }, label: {
                    Text("Sign Up")
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
