//
//  Weather.swift
//  BringYourUmbrella
//
//  Created by t2023-m0114 on 5/14/24.
//

import Foundation

struct WeatherResponse: Decodable {
    let weather: [Weather]
    let sys: Sys
    let main: Main
    let name: String
}

struct Main: Decodable {
    let temp: Double
    let feelslike: Double
    let tempmin: Double
    let tempmax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelslike = "feels_like"
        case tempmin = "temp_min"
        case tempmax = "temp_max"
    }
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Sys: Decodable {
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}