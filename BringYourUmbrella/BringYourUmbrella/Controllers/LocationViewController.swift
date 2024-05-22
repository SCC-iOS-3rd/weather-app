//
//  LocationViewController.swift
//  BringYourUmbrella
//
//  Created by Kinam on 5/21/24.
//

import UIKit
import SnapKit
import CoreData

class LocationViewController: UIViewController {
    
    // MARK: - properties
    var viewControllersList = [UIViewController]()
    var currentViewController: UIViewController?
    let mainView = MainView()
    let weatherService = WeatherService()
    let locationService = LocationService()
    let viewController = ViewController()
    
    var temperatureInCelsius: Double = 0.0
    
    //위도와 경도
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var locationName: String = ""
    
    
    // 받아온 데이터를 저장할 프로퍼티
    var weather: Weather?
    var main: Main?
    var sys: Sys?
    var name: String?
    
    
    // MARK: - methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherService.getWeather(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self.weather = weatherResponse.weather.first
                    self.main = weatherResponse.main
                    self.name = weatherResponse.name
                    self.setNewVCWeatherUI()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        swipefunc()
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    func styleRecommend() -> String {
        switch temperatureInCelsius {
        case 27...:
            return "민소매,반바지,원피스를 추천드려요"
        case 23..<27:
            return "반팔,얇은셔츠,면바지를 추천드려요"
        case 20..<23:
            return "얇은가디건,긴팔,청바지를 추천드려요"
        case 17..<20:
            return "가디건,얇은니트,청바지를 추천드려요"
        case 12..<17:
            return "자켓,가디건,야상을 추천드려요"
        case 10..<12:
            return "트렌치코트,간절기야상을 추천드려요"
        case 6..<10:
            return "울코트,가죽자켓을 추천드려요"
        case ...5:
            return "패딩,두꺼운코트,누빔옷을 추천드려요"
        default:
            return "No recommendation available"
            
        }
    }
    
    func informationRecommend() -> String {
        switch temperatureInCelsius {
        case 27...:
            return "실내 활동을 권장드려요 더위 조심하세요"
        case 23..<27:
            return "더운 날씨예요 수분을 충분히 섭취하세요"
        case 20..<23:
            return "나들이하기 좋은 날씨예요"
        case 17..<20:
            return "야외 활동이 잘 어울리는 날씨예요"
        case 12..<17:
            return "산책하기 좋은 날씨예요"
        case 10..<12:
            return "서늘한 날씨예요 감기조심하세요"
        case 6..<10:
            return "쌀쌀한 날씨예요 따뜻하게 입으시길 권장드려요"
        case ...5:
            return "추운날씨로 실내 활동을 권장드려요"
        default:
            return "추천드릴 정보가 없습니다"
            
        }
    }
    
    private func setNewVCWeatherUI() {
        temperatureInCelsius = main!.temp
        guard let weatherIcon = weather?.icon else { return }
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(weatherIcon)@2x.png") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to fetch image data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.mainView.todayweatherImageView.image = image
                }
            }
        }
        task.resume()
        
        DispatchQueue.main.async {
            self.temperatureInCelsius = self.main!.temp
            self.mainView.iconImageView.image = UIImage(named: self.weather!.icon)
            self.mainView.todayWeatherViewLabel.text = "\(self.weather!.description)"
            self.mainView.temperatureLabel.text = "\(Int(self.main!.temp))º"
            self.mainView.todayTemperatureLabel.text = "\(self.main!.temp)º"
            self.mainView.highloweViewLabel.text = "최고 \(Int(self.main!.tempmax))º ~ 최저 \(Int(self.main!.tempmin))º"
            self.mainView.todayWeatherLabel.text = "\(self.weather!.description)"
            self.mainView.todayHighLoweLabel.text = "\(Int(self.main!.tempmax))º \(Int(self.main!.tempmin))º"
            
        }
        mainView.weatherDescriptionViewLabel.text = informationRecommend()
        mainView.styleViewLabel.text = styleRecommend()
//        mainView.locationLabel.text = locationName
        mainView.timeLabel.text = viewController.datefunc()
    }
    
    func swipefunc() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
            swipeLeft.direction = .left
            self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func alarmButtonMove(sender: UIButton) {
        //        let alarmVC =
        //        present(alarmVC, animated: true)
    }
    //위치추가 화면이동
    @objc func plusButtonMove (sender: UIButton) {
        let plusVC = LocationManagementViewContorller()
        plusVC.latitude = latitude
        plusVC.longitude = longitude
        self.navigationController?.pushViewController(plusVC, animated: true)
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
          rightfunc()
          self.navigationController?.popToRootViewController(animated: true)
        }
      }
    
    func rightfunc() {
        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
      }
    
}
