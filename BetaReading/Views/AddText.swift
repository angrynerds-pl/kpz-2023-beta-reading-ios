//
//  AddText.swift
//  BetaReading
//
//  Created by Paulina on 03/04/2023.
//

import Foundation
import SwiftUI
import MobileCoreServices
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

struct AddText: View {
    @State private var title = ""
    @State private var noTitle = 0
    @State private var textEditor = "Once upon a time "
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
                TextEditor(text: ($textEditor))
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


