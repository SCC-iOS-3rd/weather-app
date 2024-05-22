//
//  File.swift
//  BringYourUmbrella
//
//  Created by t2023-m0114 on 5/20/24.
//

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
}
