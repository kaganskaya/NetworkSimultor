
//
//  Car.swift
//  NetworkSimulator
//
//  Created by liza_kaganskaya on 6/30/19.
//  Copyright © 2019 liza_kaganskaya. All rights reserved.
//

import Foundation

struct Cars: Codable {
    let carID: Int16
    let carType, carModel, carColor: String
    let owners: [Owner]
    
    enum CodingKeys: String, CodingKey {
        case carID = "car_id"
        case carType = "car_type"
        case carModel = "car_model"
        case carColor = "car_color"
        case owners
    }
}

struct Owner: Codable {
    let ownerID: Int16
    let ownerName, ownerPhone: String
    
    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case ownerName = "owner_name"
        case ownerPhone = "owner_phone"
    }
}
