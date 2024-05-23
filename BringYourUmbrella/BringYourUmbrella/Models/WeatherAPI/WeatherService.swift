//
//  File.swift
//  BringYourUmbrella
//
//  Created by 희라 on 5/14/24.
//

// ⭐️ 오픈웨더맵 api 호출⭐️

import Foundation

// 에러 정의
enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}

class WeatherService {
    
    func getWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=a4094dddc54b82d889eea64f442c3280&units=metric&lang=kr"
        guard let url = URL(string: urlString) else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            // Data 타입으로 받은 리턴을 디코드
            if let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data) {
                print(weatherResponse)
                completion(.success(weatherResponse)) // 성공한 데이터 저장
            } else {
                completion(.failure(.decodingError))
            }
        }.resume() // 이 dataTask 시작
    }
    
    func getForecastWeather(latitude: Double, longitude: Double, completion: @escaping(Result<ForecastWeatherResponse, NetworkError>) -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=a4094dddc54b82d889eea64f442c3280&units=metric&lang=kr"
        
        guard let url = URL(string: urlString) else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            if let forecastWeatherResponse = try? JSONDecoder().decode(ForecastWeatherResponse.self, from: data) {
                print(forecastWeatherResponse)
                completion(.success(forecastWeatherResponse))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
