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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        //NavigationStack{
        ZStack {
            Color(red: 67/255, green: 146/255, blue: 138/255).ignoresSafeArea()
            VStack {
                HStack(alignment: .center, spacing: 60) {
                    Text("Create account")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Image("AngryReaders")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .aspectRatio(contentMode: .fit)
                }
                
                VStack{
                    TextField("Email", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
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
                        if !showPassword{
                            SecureField("Password", text: $password)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                            
                            
                        }else {
                            TextField(password, text: $password)
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
                    .padding()
                    
                    HStack{
                        if showPassword{
                            TextField(repeatPassword, text: $repeatPassword)
                        }else {
                            SecureField("Repeat Password", text: $repeatPassword)
                            
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
                    .padding()
                    
                    if authViewModel.errorOccurred {
                        Text(authViewModel.errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty, password == repeatPassword else {
                            //authViewModel.errorOccurred = true
                            //authViewModel.errorMessage = "Please fill in all fields correctly."
                            return
                        }
                        authViewModel.signUp(email: email, password: password, name: name, surname: surname )
                        showingLoginScreen = true
                        
                    }, label: {
                        Text("Sign Up")
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 120, height: 50)
                            .background(Color(red: 254/255, green: 144/255, blue: 42/255))
                            .cornerRadius(20)
                    })
                    
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 120, height: 50)
                    .background(Color(red: 254/255, green: 144/255, blue: 42/255))
                    .cornerRadius(20)
                    .onReceive(authViewModel.$errorOccurred) { errorOccurred in
                        if !errorOccurred {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
        .onAppear {
            email = ""
            password = ""
            name = ""
            surname = ""
            repeatPassword = ""
            authViewModel.errorOccurred = false
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
