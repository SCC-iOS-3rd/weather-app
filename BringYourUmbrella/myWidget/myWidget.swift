//
//  myWidget.swift
//  myWidget
//
//  Created by t2023-m0114 on 5/16/24.
//

import WidgetKit
import SwiftUI
import CoreLocation

// MARK: - WeatherResponse Model
struct WeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
    let name: String

    struct Weather: Codable {
        let description: String
        let icon: String
    }

    struct Main: Codable {
        let temp: Double
    }
}

// MARK: - getWeather
enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}

func getWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
    let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=a4094dddc54b82d889eea64f442c3280&units=metric&lang=kr"
    guard let url = URL(string: urlString) else {
        return completion(.failure(.badUrl))
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
            return completion(.failure(.noData))
        }

        if let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data) {
            completion(.success(weatherResponse))
        } else {
            completion(.failure(.decodingError))
        }
    }.resume()
}

// MARK: - UserDefaults
extension UserDefaults {
    private enum Keys {
        static let latitude = "latitude"
        static let longitude = "longitude"
    }
    
    func setLocation(latitude: Double, longitude: Double) {
        set(latitude, forKey: Keys.latitude)
        set(longitude, forKey: Keys.longitude)
    }
    
    func getLocation() -> CLLocationCoordinate2D? {
        let latitude = double(forKey: Keys.latitude)
        let longitude = double(forKey: Keys.longitude)
        
        // 좌표가 유효한지 확인
        if latitude != 0.0 || longitude != 0.0 {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            return nil
        }
    }
}

// MARK: - Widget

// Provider 정의
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), location: "여의도", nowWeather: "흐림", icon: "cloud.fill", temperature: 20.0, latitude: 1.27, longitude: 2.38)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let location = UserDefaults.standard.getLocation() ?? CLLocationCoordinate2D(latitude: 1.27, longitude: 2.38)
        getWeather(latitude: location.latitude, longitude: location.longitude) { result in
            let nowWeather: String
            let temperature: Double
            let icon: String
            let locationName: String
            switch result {
            case .success(let weatherResponse):
                nowWeather = weatherResponse.weather.first?.description ?? "Unknown"
                temperature = weatherResponse.main.temp
                icon = weatherResponse.weather.first?.icon ?? "cloud.fill"
                locationName = weatherResponse.name
            case .failure:
                nowWeather = "Error"
                temperature = 0.0
                icon = "xmark.circle.fill"
                locationName = "Unknown"
            }
            let entry = SimpleEntry(date: Date(), location: locationName, nowWeather: nowWeather, icon: icon, temperature: temperature, latitude: location.latitude, longitude: location.longitude)
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        let threeHoursLater = Calendar.current.date(byAdding: .hour, value: 3, to: currentDate)!

        let location = UserDefaults.standard.getLocation() ?? CLLocationCoordinate2D(latitude: 1.27, longitude: 2.38)
        getWeather(latitude: location.latitude, longitude: location.longitude) { result in
            let nowWeather: String
            let temperature: Double
            let icon: String
            let locationName: String
            switch result {
            case .success(let weatherResponse):
                nowWeather = weatherResponse.weather.first?.description ?? "Unknown"
                temperature = weatherResponse.main.temp
                icon = weatherResponse.weather.first?.icon ?? "cloud.fill"
                locationName = weatherResponse.name
            case .failure:
                nowWeather = "Error"
                temperature = 0.0
                icon = "xmark.circle.fill"
                locationName = "Unknown"
            }
            let entry = SimpleEntry(date: currentDate, location: locationName, nowWeather: nowWeather, icon: icon, temperature: temperature, latitude: location.latitude, longitude: location.longitude)
            entries.append(entry)
            let timeline = Timeline(entries: entries, policy: .after(threeHoursLater))
            completion(timeline)
        }
    }
}

// 엔트리
struct SimpleEntry: TimelineEntry {
    let date: Date
    let location: String
    let nowWeather: String
    let icon: String
    let temperature: Double
    let latitude: Double
    let longitude: Double
}

// 뷰
struct myWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            // 1. 지역 / 날짜 / 요일
            Text("\(getFormattedDate(entry.date)) \(entry.location)")
                .font(.caption)
                .fontWeight(.regular)
                .foregroundColor(.white)

            // 2. 날씨와 온도
            Text("\(entry.nowWeather) \(Int(entry.temperature))ºC")
                .font(.title3)
                .fontWeight(.regular)
                .foregroundColor(.white)

            // 3. 아이콘
            Image(entry.icon) // 날씨에 따라 가변하도록 변경 예정
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35, height: 35)
        }
        .padding(.all, 10)
        .background(Image("widgetBG"))
    }
}

// 날짜 / 요일 데이터 가져오기
func getFormattedDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "M / d E"
    return dateFormatter.string(from: date)
}

// 위젯 정의
struct myWidget: Widget {
    let kind: String = "BringYourUmbrella.myWidget" // 위젯을 식별하는 문자열

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                myWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                myWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("우산 챙겨")
        .description(".")
        .supportedFamilies([.systemSmall, .systemMedium]) // 지원하는 위젯 크기
    }
}

#Preview(as: .systemSmall) {
    myWidget()
} timeline: {
    SimpleEntry(date: .now, location: "서울", nowWeather: "", icon: "cloud.fill", temperature: 20.0, latitude: 1.27, longitude: 2.38)
    SimpleEntry(date: .now, location: "부산", nowWeather: "", icon: "cloud.fill", temperature: 20.0, latitude: 1.27, longitude: 2.38)
}
