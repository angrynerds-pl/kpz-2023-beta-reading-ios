//
//  UserModel.swift
//  BetaReading
//
//  Created by Julia Gościniak on 22/05/2023.
//

import Foundation

struct User {
    let uid: String
    let email: String
    let firstName: String
    let lastName: String

    // Konstruktor
    init(uid: String, email: String, firstName: String, lastName: String) {
        self.uid = uid
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
    }
}
