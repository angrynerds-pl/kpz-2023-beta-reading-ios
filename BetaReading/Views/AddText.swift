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
    @State private var showAlert = false

    var body: some View {
        ZStack {
            Color(red: 67/255, green: 146/255, blue: 138/255).ignoresSafeArea()
            VStack {
                HStack(
                    alignment: .center,
                    spacing: 100
                ) {
                    Text("AddText")
                        .font(.title.weight(.bold))
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
                    .border(Color.red, width: CGFloat(noTitle))
                    .padding(.bottom, 25)
                TextEditor(text: $textMessage)
                    .padding()
                    .frame(width: 300, height: 400)
                    .background(Color(red: 217/255, green: 217/255, blue: 217/255))
                    .cornerRadius(10)
                HStack {
                    Text("or")
                        .foregroundColor(.white)
                    Button("Attach File 📎") {
                        self.showDocumentPicker.toggle()
                    }
                    .sheet(isPresented: $showDocumentPicker) {
                        DocumentPicker(showAlert: self.$showAlert, title: self.title, textMessage: self.textMessage) // Rename `alert` to `showAlert`
                    }
                    .alert(isPresented: $showAlert) { // Rename `alert` to `showAlert`
                        Alert(title: Text("Message"), message: Text("Uploaded successfully ✅"), dismissButton: .default(Text("OK 👍")))
                    }
                    .foregroundColor(.white)
                }
                .padding()
                HStack {
                    Button("Submit") {
                        convertToPdfFileAndShare(textContent: textMessage, title: title, showAlert: self.$showAlert) // Pass showAlert as a binding
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
        return Coordinator(parent: self)
    }

    typealias UIViewControllerType = UIDocumentPickerViewController

    @Binding var showAlert: Bool
    var title: String
    var textMessage: String

    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
        // Nothing to update here
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker

        init(parent: DocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let fileURL = urls.first else { return }

            let userID = Auth.auth().currentUser?.uid ?? ""
            let fileName = "\(userID)_\(self.parent.title).pdf"

            let storageRef = Storage.storage().reference().child(fileName)
            storageRef.putFile(from: fileURL, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Error uploading file to Firebase Storage: \(error.localizedDescription)")
                    return
                }

                storageRef.downloadURL { (url, error) in
                    if let error = error {
                        print("Error retrieving file URL: \(error.localizedDescription)")
                        return
                    }

                    guard let downloadURL = url else {
                        print("File URL is nil")
                        return
                    }

                    let userID = Auth.auth().currentUser?.uid ?? ""

                    let db = Firestore.firestore()
                    let documentData: [String: Any] = [
                        "author": userID,
                        "title": self.parent.title,
                        "userID": userID,
                        "fileURL": downloadURL.absoluteString,
                        "timestamp": Timestamp(),
                        "textId": UUID().uuidString // Generate unique ID for text document
                    ]

                    db.collection("Text").addDocument(data: documentData) { error in
                        if let error = error {
                            print("Error adding document to Firestore: \(error.localizedDescription)")
                        } else {
                            print("Document added to Firestore")
                            DispatchQueue.main.async {
                                self.parent.showAlert.toggle()
                            }
                        }
                    }
                }
            }
        }
    }
}

func convertToPdfFileAndShare(textContent: String, title: String, showAlert: Binding<Bool>) {
    let fmt = UIMarkupTextPrintFormatter(markupText: textContent)
    let render = UIPrintPageRenderer()
    render.addPrintFormatter(fmt, startingAtPageAt: 0)
    let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
    render.setValue(page, forKey: "paperRect")
    render.setValue(page, forKey: "printableRect")
    let pdfData = NSMutableData()
    UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
    for i in 0..<render.numberOfPages {
        UIGraphicsBeginPDFPage()
        render.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
    }
    UIGraphicsEndPDFContext()

    let userID = Auth.auth().currentUser?.uid ?? ""
    let fileName = "\(userID)_\(title).pdf"
    guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fileName) else {
        fatalError("Destination URL not created")
    }

    pdfData.write(to: outputURL, atomically: true)
    print("open \(outputURL.path)")

    if FileManager.default.fileExists(atPath: outputURL.path) {
        let storageRef = Storage.storage().reference().child(fileName)
        storageRef.putFile(from: outputURL, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Error uploading file to Firebase Storage: \(error.localizedDescription)")
                return
            }

            storageRef.downloadURL { (url, error) in
                if let error = error {
                    print("Error retrieving file URL: \(error.localizedDescription)")
                    return
                }

                guard let downloadURL = url else {
                    print("File URL is nil")
                    return
                }

                let userID = Auth.auth().currentUser?.uid ?? ""

                let db = Firestore.firestore()
                let documentData: [String: Any] = [
                    "author": userID,
                    "title": "\(userID)_\(title)",
                    "userID": userID,
                    "fileURL": downloadURL.absoluteString,
                    "timestamp": Timestamp(),
                    "textId": UUID().uuidString // Generate unique ID for text document
                ]

                db.collection("Text").addDocument(data: documentData) { error in
                    if let error = error {
                        print("Error adding document to Firestore: \(error.localizedDescription)")
                    } else {
                        print("Document added to Firestore")
                        DispatchQueue.main.async {
                            showAlert.wrappedValue = true
                        }
                    }
                }
            }
        }
    } else {
        print("Document was not found")
    }
}
