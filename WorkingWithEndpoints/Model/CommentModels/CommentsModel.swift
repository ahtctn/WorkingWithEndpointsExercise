//
//  CommentModel.swift
//  WorkingWithEndpoints
//
//  Created by Ahmet Ali ÇETİN on 20.07.2023.
//

import Foundation

struct CommentsModel: Codable {
    let postID, id: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}

typealias CommentsArray = [CommentsModel]
