//
//  MyTextsView.swift
//  BetaReading
//
//  Created by Julia Gościniak on 24/05/2023.
//

import SwiftUI

struct MyTextsView: View {
    @ObservedObject var viewModel = HomeViewModel()
        @State private var showNewView = false
        @State private var showPDF = false // Dodane pole @State
        @State private var selectedPDFURL: URL?// Dodane pole @State

       // @EnvironmentObject var userr: User // Dodane pole @EnvironmentObject

        var body: some View {
            ZStack {
                Color(red: 67/255, green: 146/255, blue: 138/255).ignoresSafeArea()
                VStack {
                    HStack(spacing: 60) {
                        VStack(alignment: .leading, spacing: 10){
                            Text("My Texts")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            NavigationLink("Add text +", destination: AddText())
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                        }
                        Image("AngryReaders")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .aspectRatio(contentMode: .fit)
                    }
                    VStack(alignment: .leading) {
                        List {
                            ForEach(viewModel.list) { item in
                                if viewModel.checkUserId(item.author) { // Sprawdzanie pola "userid" dla każdego elementu i porównywanie z bieżącym użytkownikiem
                                    Section {
                                        Text(item.title)
                                            .fontWeight(.bold)
                                        Text(item.author)

                                        Text(item.content)
//                                        Button("Open PDF") {
//                                        //    viewModel.fetchPDFURL(for: item.author, title: item.title)
//                                            showPDF = true // Ustawienie wartości na true po naciśnięciu przycisku
//                                        }
                                        Button("Open PDF") {
                                            viewModel.fetchPDFURL(for: item.author, title: item.title) { pdfURL in
                                                selectedPDFURL = pdfURL
                                                showPDF = true
                                            }
                                        }
                                    }
                                    .listRowBackground(Color(red: 217/255, green: 217/255, blue: 217/255))
                                    .listRowBackground(RoundedRectangle(cornerRadius: 5))
                                    .listRowSeparator(.hidden)
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                        Spacer()
                    }
                }
            }
            .sheet(isPresented: $showPDF) { // Wyświetlanie arkusza jako model
                if let pdfURL = selectedPDFURL {
                    PDFViewContainer(pdfURL: pdfURL)
                        .edgesIgnoringSafeArea(.all) // Dodatkowe dostosowanie dla arkusza modalnego
                }
            }
        }

        init() {
            viewModel.getData()
        }
    }
struct MyTextsView_Previews: PreviewProvider {
    static var previews: some View {
        MyTextsView()
    }
}
