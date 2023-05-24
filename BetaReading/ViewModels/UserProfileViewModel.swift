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
        db.collection("Users").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.users = documents.map { (queryDocumentSnapshot) -> User in
                let data = queryDocumentSnapshot.data()
                let uid = data["uid"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let surname = data["surname"] as? String ?? ""
               
                return User(uid: uid, email: email, name: name, surname: surname)
            }
        }
    }
}
