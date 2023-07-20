//
//  TodosModel.swift
//  WorkingWithEndpoints
//
//  Created by Ahmet Ali ÇETİN on 20.07.2023.
//

import Foundation

struct TodosModel: Codable {
    let userID, id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}

typealias TodosArray = [TodosModel]
