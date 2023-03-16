//
//  ListDogsVIPModels.swift
//  WizelineArchitectuesSMES
//
//  Created by Adrian Piedra on 10/03/23.
//

import Foundation

enum ListDogs {
    struct DisplayedDog {
        let name: String
        let imageUrl: String
        let date: String
    }
}

struct Dog: Codable {
    let id: Int
    let name: String
    let imageUrl: String
}

enum DogListAPIStatus {
    case loading
    case finished(data: [Dog])
    case error  //Never happend for this example
}
