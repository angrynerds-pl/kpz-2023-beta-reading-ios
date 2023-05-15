//
//  AddText.swift
//  BetaReading
//
//  Created by Paulina on 03/04/2023.
//

import Foundation
import SwiftUI
import UIKit
import MobileCoreServices
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

struct AddText: View {
    @State private var title = ""
    @State private var noTitle = 0
    @State private var textMessage: String = ""
    @State private var showDocumentPicker = false
    @State var alert = false
    
    var body: some View {
        ZStack {
            Color(red: 67/255, green: 146/255, blue: 138/255).ignoresSafeArea()
            VStack {
                
                HStack(
                    alignment: .center,
                    spacing: 100
                ) {
                    
                    Text("AddText")
                        .font(
                            .title
                                .weight(.bold))
                        .foregroundColor(.white)
                    
                    Image("AngryReaders")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .aspectRatio(contentMode: .fit)
                    
                    
                }
                .padding(.bottom, 20)
                TextField("Title", text: $title)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(noTitle))
                    .padding(.bottom, 25)
                TextEditor(text: ($textMessage))
                    .padding()
                    .frame(width: 300, height: 400)
                    .scrollContentBackground(.hidden)
                    .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                    .cornerRadius(10)
                HStack {
                    
                    Text("or")
                        .foregroundColor(.white)
                    
                    Button("Attach File 📎") {
                        self.showDocumentPicker.toggle()
                    }
                    .sheet(isPresented: $showDocumentPicker) {
                        DocumentPicker(alert: self.$alert)
                    }
                    .alert(isPresented: $alert) {
                        Alert(title: Text("Message"), message: Text("Uploaded succesfully ✅"), dismissButton: .default(Text("OK 👍")))
                    }
                    .foregroundColor(.white)
                }
                .padding()
                
                HStack{
                    Button("Submit") {
                        convertToPdfFileAndShare(textContent: textMessage)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 120, height: 50)
                    .background(Color(red: 254/255, green: 144/255, blue: 42/255))
                    .cornerRadius(20)
                    
                }
            }
            }
        }
    }

struct AddText_Previews: PreviewProvider {
    static var previews: some View {
        AddText()
    }
}

struct DocumentPicker: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return DocumentPicker.Coordinator(parent1: self)
    }
    
    typealias UIViewControllerType = UIDocumentPickerViewController

    @Binding var alert : Bool

    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
        // Nothing to update here
    }

    class Coordinator : NSObject, UIDocumentPickerDelegate {

        var parent : DocumentPicker

        init(parent1 : DocumentPicker) {
            parent = parent1
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {

            let bucket = Storage.storage().reference()

            bucket.child((urls.first?.deletingPathExtension().lastPathComponent)!).putFile(from: urls.first!, metadata: nil) {
                (_, err) in

                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }

                print("success")
                self.parent.alert.toggle()

            }
        }
    }
}

func convertToPdfFileAndShare(textContent: String){
    
    let fmt = UIMarkupTextPrintFormatter(markupText: textContent)
    
    // 2. Assign print formatter to UIPrintPageRenderer
    let render = UIPrintPageRenderer()
    render.addPrintFormatter(fmt, startingAtPageAt: 0)
    
    // 3. Assign paperRect and printableRect
    let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
    render.setValue(page, forKey: "paperRect")
    render.setValue(page, forKey: "printableRect")
    
    // 4. Create PDF context and draw
    let pdfData = NSMutableData()
    UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
    
    for i in 0..<render.numberOfPages {
        UIGraphicsBeginPDFPage();
        render.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
    }
    
    UIGraphicsEndPDFContext();
    
    // 5. Save PDF file
    guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("output").appendingPathExtension("pdf")
        else { fatalError("Destination URL not created") }
    
    pdfData.write(to: outputURL, atomically: true)
    print("open \(outputURL.path)")
    
    if FileManager.default.fileExists(atPath: outputURL.path){
        
        let url = URL(fileURLWithPath: outputURL.path)
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
//        activityViewController.popoverPresentationController?.sourceView = self.view
        
        //If user on iPad
        if UIDevice.current.userInterfaceIdiom == .pad {
            if activityViewController.responds(to: #selector(getter: UIViewController.popoverPresentationController)) {
            }
        }
//        present(activityViewController, animated: true, completion: nil)

    }
    else {
        print("document was not found")
    }
    

}
