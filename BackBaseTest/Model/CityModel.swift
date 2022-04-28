//
//  CityModel.swift
//  BackBaseTest
//
//  Created by Veaceslav Chirita on 26.04.2022.
//

import Foundation

struct City: Decodable, Equatable {
    let country, name: String
    let id: Int
    let coord: Coord
    
    private enum CodingKeys : String, CodingKey {
        case country, name
        case id = "_id"
        case coord
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name
    }
}

struct Coord: Decodable {
    let lon, lat: Double
}
