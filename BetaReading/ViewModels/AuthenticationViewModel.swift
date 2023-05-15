//
//  AuthenticationViewModel.swift
//  BetaReading
//
//  Created by Julia Gościniak on 11/05/2023.
//

import Foundation
import FirebaseAuth

class AuthenticationViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool{
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){[weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            DispatchQueue.main.async {
                if Auth.auth().currentUser?.uid != nil {
                    self?.signedIn = true
                    
                    }else{
                        return
                    }
                //Success
                //self?.signedIn = true
            }
            
        }
    }
    
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password){[weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            DispatchQueue.main.async {
                //Success
                self?.signedIn = true
            }
        }
    }
    
    func signOut (){
        try? auth.signOut()
        
        if Auth.auth().currentUser?.uid != nil {

          return
            }else{
                self.signedIn = false
                print("log out")
            }
        
//        self.signedIn = false
//        print("log out")
    }
    
    
    func resetPassword(email: String) {
            auth.sendPasswordReset(withEmail: email) { error in
                if error != nil {
                    // Obsługa błędu przy wysyłaniu linka do resetowania hasła
                    return
                }
                // Pomyślnie wysłano link do resetowania hasła
                print("wysłano link")
            }
        }
}
