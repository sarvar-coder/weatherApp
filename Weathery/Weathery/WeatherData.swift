//
//  WeatherData.swift
//  Weathery
//
//  Created by Sarvar Boltaboyev on 10/02/25.
//

import Foundation

struct WeatherData: Codable {
    let coord: Coordinate
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Coordinate: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}

struct Main: Codable {
    let temp: Double
    
}


