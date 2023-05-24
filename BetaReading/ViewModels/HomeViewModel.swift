//
//  HomeViewModel.swift
//  BetaReading
//
//  Created by Julia Gościniak on 15/05/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseCore
import Combine
import Firebase
import FirebaseStorage
import PDFKit

class HomeViewModel: ObservableObject{

    @Published var list = [HomeModel]()
    private let storage = Storage.storage()
    private let db = Firestore.firestore()
    @Published var pdfURL: URL?
    
    
    func getData(){
        //let db = Firestore.firestore()
        db.collection("Text").getDocuments{snapshot, error in
            if error == nil{
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map{ d in
                            return HomeModel(id: d.documentID,
                                             author: d["author"] as? String ?? "",
                                             content: d["content"] as? String ?? "",
                                             timestamp: d["timestamp"] as? String ?? "",
                                             title: d["title"] as? String ?? "",
                                             userId: d["userId"] as? String ?? ""
                            )
                        }
                    }
                }
            } else{
                //Error handling
            }
        }
    }
    
    func fetchPDFURL(for itemId: String, title: String) {
            let query = db.collection("Text")
                .whereField("author", isEqualTo: itemId)
                .whereField("title", isEqualTo: title)
            query.getDocuments { snapshot, error in
                if let document = snapshot?.documents.first,
                   let fileURL = document.data()["fileURL"] as? String {
                    self.pdfURL = URL(string: fileURL)
                    
                }
                print("")
                print("")
                print(self.pdfURL as Any)
            }
        }
    
    func checkUserId(_ userId: String) -> Bool {
        guard let currentUser = Auth.auth().currentUser else {
            return false // Jeśli nie ma zalogowanego użytkownika, zwróć false lub odpowiednią wartość domyślną
        }
        
        return userId == currentUser.uid
    }
}
