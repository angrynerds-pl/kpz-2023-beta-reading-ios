//
//  TestUIView.swift
//  BetaReading
//
//  Created by Julia Gościniak on 17/05/2023.
//

import SwiftUI

struct UserProfileView: View {
    
    //@ObservedObject var authViewModel = AuthenticationViewModel

    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State private var temp = ""
    
    var body: some View {
        ZStack {
            Color(red: 67/255, green: 146/255, blue: 138/255).ignoresSafeArea()
            VStack(alignment: .leading) {
                //            List {
                //                ForEach(authViewModel.list) { item in
                //                    Section {
                //                        Text(item.name)
                //                        
                //                        Text(item.surname)
                //                    }
                //                    .listRowBackground(Color(red: 217/255, green: 217/255, blue: 217/255))
                //                    .listRowBackground(RoundedRectangle(cornerRadius: 5))
                //                    .listRowSeparator(.hidden)
                //                }
                //            }
                //            .scrollContentBackground(.hidden)
                Spacer()
            }
            
            VStack{
                HStack(alignment: .center, spacing: 60) {
                    Text("Profile")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Image("AngryReaders")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .aspectRatio(contentMode: .fit)
                }
                Spacer()
                VStack{
                    TextField("Julia", text: $temp)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                        .cornerRadius(10)
                        .padding()
                    
                    TextField("Gosciniak", text: $temp)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                        .cornerRadius(10)
                        .padding()
                    TextField("259164@student.pwr.edu.pl", text: $temp)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                        .cornerRadius(10)
                        .padding()
                    TextEditor(text: $temp)
                        .padding()
                        .frame(width: 300, height: 200)
                        .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                        .cornerRadius(10)
                    
                    Spacer()
                    Button(action: {
                        authViewModel.signOut()
                    }
                           , label: {
                        Text ("sign out")
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 120, height: 50)
                            .background(Color(red: 254/255, green: 144/255, blue: 42/255))
                            .cornerRadius(20)
                        
                    })
                    .padding()
                }

            }
        }
        
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
