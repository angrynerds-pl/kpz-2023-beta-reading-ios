//
//  ContentView.swift
//  BetaReading
//
//  Created by Julia Gościniak on 02/04/2023.
//

import SwiftUI




struct ContentView: View {
    
   //@EnvironmentObject var authViewModel: AuthenticationViewModel
   @StateObject var authViewModel = AuthenticationViewModel()
    
    var body: some View {
        NavigationView{
                    if authViewModel.signedIn{
                        TabBarView()
                            .environmentObject(authViewModel)
//                        VStack{
//                            Text("You are signed in")
//                            NavigationLink("Add text", destination: AddText())
//                                .padding()
//                            NavigationLink("Home page", destination: HomeView())
//                                .padding()
//                            Button(action: {
//                                authViewModel.signOut()
//                            }
//                                   , label: {
//                                Text ("sign out")
//
//                            })
//                        }
                    }
                    else{
                        SignInView()
                            .environmentObject(authViewModel)
                    }
                }
                .onAppear{
                    authViewModel.signedIn = authViewModel.isSignedIn
                }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
