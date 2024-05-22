//
//  MainViewController.swift
//  BringYourUmbrella
//
//  Created by Hee  on 5/21/24.
//

import UIKit
import SnapKit
import CoreLocation


protocol LocationDelegate: AnyObject {
    func didUpdateLocation(latitude: Double, longitude: Double)
}
//메인페이지 vc1페이지
class MainViewController: BaseViewController {
    
    //현재위치 부분
    var locationManager = CLLocationManager()
    //api
    let weatherService = WeatherService()
    var weather: Weather?
    var sys: Sys?
    var main: Main?
    var name: String?
    let todayWeatherStackView = UIStackView()
    
    //위도와 경도
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    //섭씨 화씨 변경 임의값 넣어둔것
    var temperatureInCelsius: Double = 0.0
    
    //뷰안에들은 Label들
    let todayWeatherViewLabel = UILabel()
    let temperatureLabel = UILabel()
    let highloweViewLabel = UILabel()
    let styleViewLabel = UILabel()
    let weatherDescriptionViewLabel = UILabel()
    //가운데view
    let iconImageView = UIImageView()
    let todayWeatherView = UIView()
    let highloweTemperatureView = UIView()
    let styleView = UIView()
    let weatherDescriptionView = UIView()
    
    //로케이션 델리게이트
    weak var locationDelegate: LocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationManager()
    }
    //MARK: - 오토레이아웃
    override func setupConstraints() {
        [todayWeatherView, highloweTemperatureView, styleView, weatherDescriptionView].forEach {
            view.addSubview($0)
        }
        [todayWeatherViewLabel, temperatureLabel].forEach {
            todayWeatherStackView.addArrangedSubview($0)
        }
        [iconImageView, todayWeatherStackView].forEach {
            todayWeatherView.addSubview($0)
        }
        //View안에 Label넣기
        highloweTemperatureView.addSubview(highloweViewLabel)
        styleView.addSubview(styleViewLabel)
        weatherDescriptionView.addSubview(weatherDescriptionViewLabel)
        //오늘날씨View
        todayWeatherView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.greaterThanOrEqualTo(todayWeatherStackView.snp.width).offset(20)
        }
        //최고~최저기온View
        highloweTemperatureView.snp.makeConstraints {
            $0.top.equalTo(todayWeatherView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.greaterThanOrEqualTo(highloweViewLabel.snp.width).offset(20)
        }
        //스타일추천View
        styleView.snp.makeConstraints {
            $0.top.equalTo(highloweTemperatureView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.greaterThanOrEqualTo(styleViewLabel.snp.width).offset(20)
        }
        //날씨정보View
        weatherDescriptionView.snp.makeConstraints {
            $0.top.equalTo(styleView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.greaterThanOrEqualTo(weatherDescriptionViewLabel.snp.width).offset(20)
        }
        //날씨정보 뷰안에 날씨+온도 스텍
        todayWeatherStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 10))
        }
        //최고~최저기온Label
        highloweViewLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        //스타일추천View
        styleViewLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        //날씨정보View
        weatherDescriptionViewLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        //오늘날씨 View의 날씨Icon
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.verticalEdges.equalToSuperview().inset(15)
            $0.trailing.equalTo(todayWeatherStackView.snp.leading)
            $0.centerY.equalToSuperview()
        }
    }
    //MARK: - UI속성
    override func configureUI() {
        iconImageView.contentMode = .scaleAspectFit
        todayWeatherStackView.distribution = .equalSpacing
        styleView(todayWeatherView)
        styleView(highloweTemperatureView)
        styleView(styleView)
        styleView(weatherDescriptionView)
        todayWeatherViewLabel.text = "지역을 찾고 있어요"
        highloweViewLabel.text = "최고 ~ 최저기온"
        styleViewLabel.text = "날씨에 따른 스타일을 추천해 드릴게요"
        weatherDescriptionViewLabel.text = "날씨에 따른 정보를 제공해드릴게요"
        todayWeatherStackView.spacing = 10
    }
    
    //view의 색상,코너값
    func styleView(_ view: UIView, backgroundColor: UIColor = .white, cornerRadius: CGFloat = 10) {
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
   }
}
//MARK: - 단위변경
extension MainViewController {

    // 버튼에 맞게 섭씨화씨 변경 
    func updateTemperatureLabel(unit: String) {
        if unit == "ºC" {
            temperatureLabel.text = "\(Int(temperatureInCelsius))º"
            highloweViewLabel.text = "최고 \(Int(main!.tempmax))º ~ 최저 \(Int(main!.tempmin))º"
        } else {
            let temperatureInFahrenheit = Int(temperatureInCelsius * 9 / 5 + 32)
            let maxTemperatureInFahrenheit = Int(main!.tempmax * 9 / 5 + 32)
            let minTemperatureInFahrenheit = Int(main!.tempmin * 9 / 5 + 32)
            temperatureLabel.text = "\(temperatureInFahrenheit)º"
            highloweViewLabel.text = "최고 \(maxTemperatureInFahrenheit)ºF ~ 최저 \(minTemperatureInFahrenheit)ºF "
        }
    }
}
//MARK: - 스타일추천,정보추천
extension MainViewController {
    
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
}
//MARK: - 현재위치,날씨가져오기
extension MainViewController: CLLocationManagerDelegate {

    private func setLocationManager() {
        //델리게이트 설정
        locationManager.delegate = self
        //거리 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //위치 사용 허용 알림
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            switch manager.authorizationStatus {
            case .notDetermined:
                // 위치 사용 허용 알림 (이미 requestWhenInUseAuthorization 호출됨)
                break
            case .restricted, .denied:
                print("위치 권한이 거부되었습니다")
            case .authorizedWhenInUse, .authorizedAlways:
                // 위치 사용을 허용하면 현재 위치정보 가져옴
                manager.requestLocation()
            @unknown default:
                fatalError("fatalError")
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("위치 업데이트")
            print("위도:\(location.coordinate.latitude)")
            print("경도:\(location.coordinate.longitude)")
            
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            locationDelegate?.didUpdateLocation(latitude: latitude, longitude: longitude)
            featchWeatherData()
        }
    }
    
    private func featchWeatherData() {
        // data fetch
        weatherService.getWeather(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self.weather = weatherResponse.weather.first
                    self.main = weatherResponse.main
                    self.name = weatherResponse.name
                    self.setWeatherUI()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
      //이미지랑 레이블정보 띄우는부분
        private func setWeatherUI() {
            temperatureInCelsius = main!.temp
            iconImageView.image = UIImage(named: weather!.icon)
            todayWeatherViewLabel.text = "\(weather!.description)"
            temperatureLabel.text = "\(Int(main!.temp))º"
            highloweViewLabel.text = "최고 \(Int(main!.tempmax))º ~ 최저 \(Int(main!.tempmin))º"
            styleViewLabel.text = styleRecommend()
            weatherDescriptionViewLabel.text = informationRecommend()
        }
}
