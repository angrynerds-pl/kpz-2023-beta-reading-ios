//
//  TestUIView.swift
//  BetaReading
//
//  Created by Julia Gościniak on 17/05/2023.
//
//
import SwiftUI
import FirebaseAuth

struct UserProfileView: View {

  //  @ObservedObject var profileViewModel = UserProfileViewModel

    @EnvironmentObject var authViewModel: AuthenticationViewModel
    let auth = Auth.auth()
    @ObservedObject var userProfileViewModel = UserProfileViewModel()

    var userId = Auth.auth().currentUser?.uid ?? ""
    @State private var temp = ""
   // let user = userProfileViewModel.users.first(where: { $0.uid == userId })
   

    var body: some View {
        ZStack {
            Color(red: 67/255, green: 146/255, blue: 138/255).ignoresSafeArea()
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
                    if let user = userProfileViewModel.users.first(where: { $0.uid == userId }) {
                        
                        Text(user.name)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                            .cornerRadius(10)
                            .padding()
                        
                        Text(user.surname)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                            .cornerRadius(10)
                            .padding()
                        
                        Text(user.email)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                            .cornerRadius(10)
                            .padding()
                    }
                        else{
                            Text("Name")
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                                .cornerRadius(10)
                                .padding()
                                
                            
                            Text("Surname")
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                                .cornerRadius(10)
                                .padding()
                            
                            Text("Email")
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                                .cornerRadius(10)
                                .padding()
                        }
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
    init() {
            userProfileViewModel.fetchData()
        }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

