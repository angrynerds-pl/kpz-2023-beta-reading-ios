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
    @State private var selectedPDFURL: URL?// Dodane pole @State

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
//                                Button("Open PDF") {
//                                    viewModel.fetchPDFURL(for: item.author, title: item.title)
//                                    selectedPDFURL = viewModel.pdfURL
//                                    //print("view:", viewModel.pdfURL as Any)
//                                    print("selectedPDFURL:", selectedPDFURL as Any)
//                                    showPDF = true // Ustawienie wartości na true po naciśnięciu przycisku
//                                }
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

//struct PDFViewContainer: View {
//    let pdfURL: URL
//    @Environment(\.presentationMode) var presentationMode // Dodane pole @Environment
//
//    var body: some View {
//        VStack {
//            PDFKitView(url: pdfURL)
//                .edgesIgnoringSafeArea(.all)
//            Button("Zamknij") {
//                presentationMode.wrappedValue.dismiss()// Zamknięcie widoku PDF
//            }
//            .padding()
//        }
//    }
//}
//
//struct PDFKitView: UIViewRepresentable {
//    let url: URL
//
//    func makeUIView(context: Context) -> PDFView {
//        let pdfView = PDFView()
//        DispatchQueue.global().async {
//            let pdfDocument = PDFDocument(url: url)
//            DispatchQueue.main.async {
//                pdfView.document = pdfDocument
//            }
//        }
//        return pdfView
//    }
//
//    func updateUIView(_ uiView: PDFView, context: Context) {
//        if let currentDocument = uiView.document, currentDocument.documentURL != url {
//            uiView.document = nil // Resetowanie aktualnego dokumentu
//            DispatchQueue.global().async {
//                let pdfDocument = PDFDocument(url: url)
//                DispatchQueue.main.async {
//                    uiView.document = pdfDocument
//                }
//            }
//        }
//    }
//}
//
//
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
