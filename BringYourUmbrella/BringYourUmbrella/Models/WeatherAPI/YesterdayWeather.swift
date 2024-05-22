//
//  YesterdayWeather.swift
//  BringYourUmbrella
//
//  Created by Hee  on 5/20/24.
//

//Weather api 데이터 모델
import Foundation


struct YesterdayWeather: Decodable {
    let location: WeatherLocation
    let forecast: Forecast
}

struct Forecast: Decodable {
    let forecastday: [Forecastday]
}

struct WeatherLocation: Decodable {
    let name, region, country: String
    let lat, lon: Double
    let tzID: String
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtime
    }
}
//어제 정보
struct Forecastday: Decodable {
    let date: String
    let day: Day
    let astro: Astro
    let hour: [Hour]

    enum CodingKeys: String, CodingKey {
        case date
        case day, astro, hour
    }
}
//어제 정보온도
struct Day: Decodable {
    let maxtempC: Double
    let mintempC, avgtempC: Double
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case avgtempC = "avgtemp_c"
        case condition
    }
}

struct Condition: Decodable {
    let text, icon: String
}

struct Hour: Decodable {
    let time: String
    let tempC: Double
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case condition
    }
}

struct Astro: Decodable {
    let sunrise, sunset, moonrise, moonset: String

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
    }
}


