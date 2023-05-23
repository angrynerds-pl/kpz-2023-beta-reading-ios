//
//  TestUIView.swift
//  BetaReading
//
//  Created by Julia Gościniak on 17/05/2023.
//

import SwiftUI

struct TestUIView: View {
    
    //@ObservedObject var authViewModel = AuthenticationViewModel

    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        
//            if authViewModel.signedIn{
//              //ContentView()
//            }
//            else {
                Button(action: {
                    authViewModel.signOut()
                }
                , label: {
                Text ("sign out")

                })
//            }
           // showLoginView = true
        
        
    }
}

struct TestUIView_Previews: PreviewProvider {
    static var previews: some View {
        TestUIView()
    }
}
