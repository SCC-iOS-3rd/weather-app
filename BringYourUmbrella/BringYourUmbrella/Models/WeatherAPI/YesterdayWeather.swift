//
//  YesterdayWeather.swift
//  BringYourUmbrella
//
//  Created by Hee  on 5/20/24.
//

//Weather api 데이터 모델
import Foundation


struct YesterdayWeather: Decodable {
    let forecast: Forecast
    
    enum CodingKeys: String, CodingKey {
        case forecast = "forecast"
    }
}

struct Forecast: Decodable {
    let forecastday: [ForecastDay]
    
    enum CodingKeys: String, CodingKey {
        case forecastday = "forecastday"
    }
}

struct ForecastDay: Decodable {
    let date: String
    let day: Day
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case day = "day"
    }
}

struct Day: Decodable {
    let maxtempC: Double
    let mintempC: Double
    let avgtempC: Double
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case avgtempC = "avgtemp_c"
        case condition
    }
}

struct Condition: Decodable {
    let text: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case icon = "icon"
    }
}


