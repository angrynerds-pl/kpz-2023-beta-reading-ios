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
    //@DocumentID var id: String?
    var title: String
    var author: String
}
