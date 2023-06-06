//
//  TabView.swift
//  BetaReading
//
//  Created by Julia Gościniak on 17/05/2023.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Label("", systemImage: "house")
                }
            MyTextsView()
                .tabItem {
                    Label("", systemImage: "book")
                    
                }
            UserProfileView()
                .tabItem {
                    Label("", systemImage: "person")
                }
                .environmentObject(authViewModel)
            }
        .accentColor(.black)
        .edgesIgnoringSafeArea(.bottom)
        }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
