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
    let name: String
    let surname: String

    init(uid: String, email: String, name: String, surname: String) {
        self.uid = uid
        self.email = email
        self.name = name
        self.surname = surname
    }
}
