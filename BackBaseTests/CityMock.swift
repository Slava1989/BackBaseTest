//
//  CityMock.swift
//  BackBaseTests
//
//  Created by Veaceslav Chirita on 28.04.2022.
//

import Foundation
@testable import BackBaseTest

class CityMock {
    static let unsortedArray = [
        City(country: "UA", name: "Laspi", id: 703363, coord: Coord(lon:33.733334, lat: 44.416668)),
        City(country: "CA", name: "Alexandria", id: 5883490, coord: Coord(lon:-74.632568, lat: 45.316792)),
        City(country: "BR", name: "Alexandria", id: 3407977, coord: Coord(lon:-38.015831, lat: -6.4125)),
        City(country: "ZA", name: "Alexandria", id: 1023365, coord: Coord(lon:26.41268, lat: -33.653461)),
        City(country: "VE", name: "Merida", id: 3632308, coord: Coord(lon:-71.144997, lat: 8.598333)),
        City(country: "RU", name: "Vinogradovo", id: 473537, coord: Coord(lon:38.545555, lat: 55.423332)),
        City(country: "IQ", name: "Qarah Gawl al ‘Ulyā", id: 384848, coord: Coord(lon:45.6325, lat:5.353889)),
        City(country: "RU", name: "Cherkizovo", id: 569143, coord: Coord(lon:37.728889, lat: 55.800835)),
        City(country: "UA", name: "Alupka", id: 713514, coord: Coord(lon:34.049999, lat: 44.416668)),
        City(country: "DE", name: "Lichtenrade", id: 2878044, coord: Coord(lon:13.40637, lat: 52.398441))
    ]
    
    static let sortedArray = [
        City(country: "BR", name: "Alexandria", id: 3407977, coord: Coord(lon: -38.015831, lat: -6.4125)),
        City(country: "CA", name: "Alexandria", id: 5883490, coord: Coord(lon: -74.632568, lat: 45.316792)),
        City(country: "ZA", name: "Alexandria", id: 1023365, coord: Coord(lon: 26.41268, lat: -33.653461)),
        City(country: "UA", name: "Alupka", id: 713514, coord: Coord(lon: 34.049999, lat: 44.416668)),
        City(country: "RU", name: "Cherkizovo", id: 569143, coord: Coord(lon: 37.728889, lat: 55.800835)),
        City(country: "UA", name: "Laspi", id: 703363, coord: Coord(lon: 33.733334, lat: 44.416668)),
        City(country: "DE", name: "Lichtenrade", id: 2878044, coord: Coord(lon: 13.40637, lat: 52.398441)),
        City(country: "VE", name: "Merida", id: 3632308, coord: Coord(lon: -71.144997, lat: 8.598333)),
        City(country: "IQ", name: "Qarah Gawl al ‘Ulyā", id: 384848, coord: Coord(lon: 45.6325, lat: 5.353889)),
        City(country: "RU", name: "Vinogradovo", id: 473537, coord: Coord(lon: 38.545555, lat: 55.423332))
    ]
}
