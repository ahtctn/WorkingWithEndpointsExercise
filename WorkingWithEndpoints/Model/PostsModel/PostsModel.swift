//
//  PostsModel.swift
//  WorkingWithEndpoints
//
//  Created by Ahmet Ali ÇETİN on 20.07.2023.
//

import Foundation

struct PostsModel: Codable {
    let id: Int?
    let title: String?
    let body: String?
    let userId: Int?
}

