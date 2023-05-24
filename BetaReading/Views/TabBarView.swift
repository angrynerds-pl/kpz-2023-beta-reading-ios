//
//  TabView.swift
//  BetaReading
//
//  Created by Julia Gościniak on 17/05/2023.
//

import SwiftUI

struct TabBarView: View {

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
//            TestUIView()
//                .tabItem {
//                    Label("", systemImage: "message")
//                }
            UserProfileView()
                .tabItem {
                    Label("", systemImage: "person")
                }
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
