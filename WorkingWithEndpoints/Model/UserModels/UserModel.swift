//
//  UserModel.swift
//  WorkingWithEndpoints
//
//  Created by Ahmet Ali ÇETİN on 20.07.2023.
//

import Foundation

struct UserModel: Codable {
    let id: Int
    let name, username, email: String
    let address: AddressModel
    let phone, website: String
    let company: CompanyModel
}

typealias UserArray = [UserModel]



