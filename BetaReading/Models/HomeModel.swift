//
//  HomeModel.swift
//  BetaReading
//
//  Created by Julia Gościniak on 15/05/2023.
//


import Foundation
import FirebaseFirestoreSwift

struct HomeModel: Identifiable, Codable{
    var id: String
    var author: String
    var content: String
    var timestamp: String
    var title: String
    var userId: String
    var textId: String

}
