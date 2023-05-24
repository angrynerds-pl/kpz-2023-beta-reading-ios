import SwiftUI
import PDFKit


//struct HomeView: View {
//    @ObservedObject var viewModel = HomeViewModel()
//    @State private var showNewView = false
//
//    var body: some View {
////        ZStack(alignment: .leading){
////            Color(red: 67/255, green: 146/255, blue: 138/255).ignoresSafeArea()
//        ZStack {
//            Color(red: 67/255, green: 146/255, blue: 138/255).ignoresSafeArea()
//            VStack {
//
//                HStack(
//                    alignment: .center,
//                    spacing: 60
//                ) {
//
//                    Text("Home Page")
////                        .font(
////                            .title
////                                .weight(.bold))
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//
//
//                    Image("AngryReaders")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 100)
//                        .aspectRatio(contentMode: .fit)
//
//
//                }
//            //}
//
//                VStack(alignment: .leading){
//                    List{
//                        ForEach(viewModel.list){item in
//                            Section{
//                                Text(item.title)//+"\n"+item.author)
//                                    .fontWeight(.bold)
//                                Text(item.author)
//                                Text(item.content)
//                                Button("Open PDF") {
//                                    viewModel.fetchPDFURL(for: item.author, title: item.title)
//                                }
//                            }
//                            //.padding()
//                            .listRowBackground(Color(red: 217/255, green: 217/255, blue: 217/255))
//                            .listRowBackground(
//                                RoundedRectangle(cornerRadius: 5)
//                            )
//                            .listRowSeparator(.hidden)
//
//                        }
//                    }
//                    .scrollContentBackground(.hidden)
//                    Spacer()
//                }
//
//            }
//        }
//    }
//
//    init(){
//        viewModel.getData()
//    }
//}
//
struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @State private var showNewView = false
    @State private var showPDF = false // Dodane pole @State

    var body: some View {
        ZStack {
            Color(red: 67/255, green: 146/255, blue: 138/255).ignoresSafeArea()
            VStack {
                HStack(alignment: .center, spacing: 60) {
                    Text("Home Page")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Image("AngryReaders")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .aspectRatio(contentMode: .fit)
                }
                VStack(alignment: .leading) {
                    List {
                        ForEach(viewModel.list) { item in
                            Section {
                                Text(item.title)
                                    .fontWeight(.bold)
                                Text(item.author)
                                
                                Text(item.content)
                                Button("Open PDF") {
                                    viewModel.fetchPDFURL(for: item.author, title: item.title)
                                    showPDF = true // Ustawienie wartości na true po naciśnięciu przycisku
                                }
                            }
                            .listRowBackground(Color(red: 217/255, green: 217/255, blue: 217/255))
                            .listRowBackground(RoundedRectangle(cornerRadius: 5))
                            .listRowSeparator(.hidden)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $showPDF) { // Wyświetlanie arkusza jako model
            if let pdfURL = viewModel.pdfURL {
                PDFViewContainer(pdfURL: pdfURL)
                    .edgesIgnoringSafeArea(.all) // Dodatkowe dostosowanie dla arkusza modalnego
            }
        }
    }

    init() {
        viewModel.getData()
    }
}

struct PDFViewContainer: View {
    let pdfURL: URL
    @Environment(\.presentationMode) var presentationMode // Dodane pole @Environment

    var body: some View {
        VStack {
            PDFKitView(url: pdfURL)
                .edgesIgnoringSafeArea(.all)
            Button("Zamknij") {
                presentationMode.wrappedValue.dismiss() // Zamknięcie widoku PDF
            }
            .padding()
        }
    }
}

struct PDFKitView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // Aktualizacja widoku PDFKit (jeśli wymagane)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
