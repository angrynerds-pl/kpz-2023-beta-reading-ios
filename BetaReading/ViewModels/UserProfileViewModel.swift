//
//  UserProfileViewModel.swift
//  BetaReading
//
//  Created by Julia Gościniak on 24/05/2023.
//

import Foundation
import FirebaseFirestore

class UserProfileViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {

        db.collection("Users")
            .getDocuments{snapshot, error in
            if error == nil{
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        self.users = snapshot.documents.map{ d in
                            return User(uid: d.documentID,
                                        email: d["email"] as? String ?? "",
                                        name: d["name"] as? String ?? "",
                                        surname: d["surname"] as? String ?? ""
                            )
                        }
                    }
                }
            } else{
                //Error handling
            }
        }
    }
}
