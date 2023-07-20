//
//  AlbumsModel.swift
//  WorkingWithEndpoints
//
//  Created by Ahmet Ali ÇETİN on 20.07.2023.
//

import Foundation

struct AlbumsModel: Codable {
    let userID, id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}

typealias AlbumsArray = [AlbumsModel]
