//
//  WeatherChangeViewController.swift
//  BringYourUmbrella
//
//  Created by /Chynmn/M1 pro—̳͟͞͞♡ on 5/17/24.
//

import UIKit
import SnapKit

class WeatherChangeViewController : UIViewController {
    
    private let weatherChangeView = WeatherChangeView()
    //api
    let weatherService = WeatherService()
    var weatherEntry: [WeatherEntry] = []
    var weatherInfo: WeatherInfo?
    var forecastdays: [ForecastDay] = []
    //위도 경도
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    
    override func loadView() {
        view = weatherChangeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(forecastdays)
        forecastWeatherData()
        fetchFiveDaysWeather()
        setCollectionView()
        
    }
    
    private func setCollectionView() {
        weatherChangeView.hourlyCollectionView.delegate = self
        weatherChangeView.hourlyCollectionView.dataSource = self
        weatherChangeView.hourlyCollectionView.register(HourlyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.identifier)
        weatherChangeView.weeklyCollectionView.delegate = self
        weatherChangeView.weeklyCollectionView.dataSource = self
        weatherChangeView.weeklyCollectionView.register(WeeklyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeeklyWeatherCollectionViewCell.identifier)
        weatherChangeView.hourlyCollectionView.tag = 1
        weatherChangeView.weeklyCollectionView.tag = 2
    }
    func fetchFiveDaysWeather() {
        let urlString = "http://api.weatherapi.com/v1/forecast.json?key=c9b70526c91341798a493546241305&q=\(latitude),\(longitude)&days=5&lang=ko"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let fiveDaysdata = try JSONDecoder().decode(YesterdayWeather.self, from: data)
                print("5daydata: \(fiveDaysdata)")
                self.forecastdays = fiveDaysdata.forecast.forecastday
                DispatchQueue.main.async {
                    self.weatherChangeView.weeklyCollectionView.reloadData()
                }
            } catch {
                print("디코딩 실패: \(error)")
            }
        }
        task.resume()
    }
    
    private func forecastWeatherData() {
        weatherService.getForecastWeather(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let forecastWeatherResponse):
                
                DispatchQueue.main.async {
                    self.weatherEntry = forecastWeatherResponse.list
                    self.weatherChangeView.hourlyCollectionView.reloadData()
                    self.setWeatherData()
                }
            case .failure(let error):
                print("Error : \(error)")
            }
        }
    }
    
    private func setWeatherData() {
//        hourlyWeatherCell.temperatureLabel.text = "\(Int(main!.temp))º"
        
        
    }
    
}

extension WeatherChangeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return weatherEntry.count > 7 ? 7 : weatherEntry.count
        } else if collectionView.tag == 2 {
            return forecastdays.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            guard let cell = weatherChangeView.hourlyCollectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.identifier, for: indexPath) as? HourlyWeatherCollectionViewCell else { return UICollectionViewCell() }
            let weatherEntry = weatherEntry[indexPath.row]
            cell.hourlyConfigureCell(with: weatherEntry)
            
            return cell
        } else if collectionView.tag == 2 {
            guard let cell = weatherChangeView.weeklyCollectionView.dequeueReusableCell(withReuseIdentifier: WeeklyWeatherCollectionViewCell.identifier, for: indexPath) as? WeeklyWeatherCollectionViewCell else { return UICollectionViewCell() }
            let forcastDay = forecastdays[indexPath.row]
            cell.weeklyConfigureCell(with: forcastDay)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension WeatherChangeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            let width = collectionView.bounds.width / 7
            let height = collectionView.bounds.height
            return CGSize(width: width, height: height)
        } else if collectionView.tag == 2 {
            let numberOfItemsPerRow: CGFloat = 5
            let spacing: CGFloat = 14 // 임의의 스페이싱 값, 원하는 값으로 조정 가능
            let totalSpacing = spacing * (numberOfItemsPerRow - 1)
            let cellWidth = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
            let height = collectionView.bounds.height
            return CGSize(width: cellWidth, height: height)
        }
        return CGSize.zero
    }
}
