//
//  AuthenticationViewModel.swift
//  BetaReading
//
//  Created by Julia Gościniak on 15/05/2023.
//


import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthenticationViewModel: ObservableObject {
    
    let auth = Auth.auth()
    private let firestore = Firestore.firestore()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool{
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){[weak self] result, error in
            guard result != nil, error == nil else{
                //Error handling
                return
            }
            //Success
            DispatchQueue.main.async {
                if Auth.auth().currentUser?.uid != nil {
                    self?.signedIn = true
                    print(Auth.auth().currentUser?.email as Any)
                    
                    }else{
                        return
                }
            }
            
        }
    }
    
    func signUp(email: String, password: String, firstName: String, lastName: String){
        //Creating a new user from the data
        auth.createUser(withEmail: email, password: password){[weak self] result, error in
           // guard result != nil, error == nil else{
            guard let user = result?.user, error == nil else {
                return
            }
            DispatchQueue.main.async {
                //Success
                self?.signedIn = true
                //Adding user to collection in firebase
                let userObject =  User(uid: user.uid, email: email, firstName: firstName, lastName: lastName)
                let userRef = self?.firestore.collection("Users").document(user.uid)
                    userRef?.setData(self?.userToDictionary(userObject) ?? [:]) { error in
                    if let error = error {
                    //Error handling
                        print("Error adding user: \(error.localizedDescription)")
                    } else {
                    //Sukcess
                        print("User registered successfully!")
                    }
                }
            }
        }
    }
    
    func signOut (){
        print("")
        print(Auth.auth().currentUser?.email as Any)
        try? auth.signOut()
        
        if Auth.auth().currentUser?.uid != nil {
          return
            }else{
                self.signedIn = false
                print("")
                print(Auth.auth().currentUser?.email as Any)
                
            }
    }
    
    
    func resetPassword(email: String) {
            auth.sendPasswordReset(withEmail: email) { error in
                if error != nil {
                    //Error handling
                    return
                }
                //Sukcess
                print("wysłano link")
            }
        }
    
    
    private func userToDictionary(_ user: User) -> [String: Any] {
            return [
                "email": user.email,
                "firstName": user.firstName,
                "lastName": user.lastName
            ]
        }
    
}
