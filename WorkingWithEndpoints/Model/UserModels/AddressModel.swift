//
//  AddressModel.swift
//  WorkingWithEndpoints
//
//  Created by Ahmet Ali ÇETİN on 20.07.2023.
//

import Foundation

struct AddressModel: Codable {
    let street, suite, city, zipcode: String
    let geo: GeoModel
}
