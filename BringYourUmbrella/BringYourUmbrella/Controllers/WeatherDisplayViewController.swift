//
//  WeatherDisplayViewController.swift
//  BringYourUmbrella
//
//  Created by Hee  on 5/20/24.
//

import UIKit
import SnapKit

//날씨표시페이지 vc2페이지
class WeatherDisplayViewController: BaseViewController {
    
    //api어제날씨
    var forecastday: Forecastday?
    //api
    let weatherService = WeatherService()
    var weather: Weather?
    var sys: Sys?
    var main: Main?
    var name: String?
    //위도 경도
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    //날씨표시 페이지
    let weatherIndicationView = UIView()
    let yesterdayLabel = UILabel()
    let todayLabel = UILabel()
    //차트용 얇은뷰
    let chartViewYesterdayView = UIView()
    let chartViewTodayView = UIView()
    //어제,오늘 날씨 Label
    let yesterdayWeatherLabel = UILabel()
    let todayWeatherLabel = UILabel()
    //어제,오늘 날씨 최저~최고
    let yesterdayHighLowehLabel = UILabel()
    let todayHighLoweLabel = UILabel()
    //어제,오늘 기온 Label
    let yesterdayTemperatureLabel = UILabel()
    let todayTemperatureLabel = UILabel()
    //날씨표시 페이지 아이콘이미지
    let yesterdayweatherImageView = UIImageView()
    let todayweatherImageView = UIImageView()
    //섭씨 화씨 변경 임의값 넣어둔것
    var temperatureInCelsius: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchyesterdayweather()
    }
    
    //MARK: - 오토레이아웃
    override func setupConstraints() {
        [weatherIndicationView, yesterdayLabel, todayLabel].forEach {
            view.addSubview($0)
        }
        [yesterdayWeatherLabel, todayWeatherLabel, todayweatherImageView, todayHighLoweLabel, todayTemperatureLabel, yesterdayHighLowehLabel, yesterdayweatherImageView, yesterdayTemperatureLabel].forEach {
            weatherIndicationView.addSubview($0)
        }
        weatherIndicationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(370)
            $0.width.equalTo(250)
        }
        //어제
        yesterdayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.leading.equalTo(weatherIndicationView.snp.leading).offset(60)
        }
        //오늘
        todayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.trailing.equalTo(weatherIndicationView.snp.trailing).offset(-60)
        }
        //어제날씨 표현
        yesterdayWeatherLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(60)
            $0.bottom.equalToSuperview().offset(-60)
        }
        //오늘날씨 표현
        todayWeatherLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-60)
            $0.bottom.equalToSuperview().offset(-60)
        }
        //어제이미지
        yesterdayweatherImageView.snp.makeConstraints {
            $0.bottom.equalTo(yesterdayWeatherLabel.snp.top).offset(-5)
            $0.width.height.equalTo(25)
            $0.leading.equalToSuperview().offset(60)
        }
        //오늘이미지
        todayweatherImageView.snp.makeConstraints {
            $0.bottom.equalTo(todayWeatherLabel.snp.top).offset(-5)
            $0.width.height.equalTo(25)
            $0.trailing.equalToSuperview().offset(-60)
        }
        //어제최고~최저
        yesterdayHighLowehLabel.snp.makeConstraints {
            $0.top.equalTo(yesterdayWeatherLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(55)
        }
        //오늘최고~최저
        todayHighLoweLabel.snp.makeConstraints {
            $0.top.equalTo(todayWeatherLabel.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().offset(-50)
        }
        //큰글씨레이블오늘꺼
        todayTemperatureLabel.snp.makeConstraints {
            $0.top.equalTo(todayLabel.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().offset(-45)
        }
        //큰글씨레이블어제꺼
        yesterdayTemperatureLabel.snp.makeConstraints {
            $0.top.equalTo(yesterdayLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(55)
        }
        
    }
    //MARK: - UI속성
    override func configureUI() {
        styleView(weatherIndicationView)
        yesterdayLabel.text = "어제"
        todayLabel.text = "오늘"
        todayWeatherLabel.font = UIFont.systemFont(ofSize: 13)
        yesterdayWeatherLabel.font = UIFont.systemFont(ofSize: 13)
        todayHighLoweLabel.font = UIFont.systemFont(ofSize: 12)
        yesterdayHighLowehLabel.font = UIFont.systemFont(ofSize: 12)
        todayTemperatureLabel.font = UIFont.boldSystemFont(ofSize: 30)
        yesterdayTemperatureLabel.font = UIFont.boldSystemFont(ofSize: 30)
        todayHighLoweLabel.textAlignment = .center
        yesterdayHighLowehLabel.textAlignment = .center
    }
    //view의 색상,코너값
    func styleView(_ view: UIView, backgroundColor: UIColor = .white, cornerRadius: CGFloat = 10) {
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
    }
}
//MARK: - 어제,오늘 날씨데이터
extension WeatherDisplayViewController {
    
    //어제날씨데이터 가져오기
    func fetchyesterdayweather() {
        guard let url = URL(string: "http://api.weatherapi.com/v1/history.json?key=c9b70526c91341798a493546241305&q=\(latitude),\(longitude)&dt=2024-05-19&hour=17&lang=ko") else { return }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) {data, response, error in
            if let error = error {
                print("Error",error)
            }
            guard let data = data else { return }
            guard let yesterdaydata = try? JSONDecoder().decode(YesterdayWeather.self, from: data) else {
                print("디코딩실패!")
                return
            }
            print("어제날씨데이터\n",yesterdaydata)
            self.forecastday = yesterdaydata.forecast.forecastday.first
            DispatchQueue.main.async {
                self.yesterdayHighLowehLabel.text = "\(Int(self.forecastday!.day.maxtempC))º \(Int(self.forecastday!.day.mintempC))º"
                self.yesterdayTemperatureLabel.text = "\(Int(self.forecastday!.day.avgtempC))º"
                self.yesterdayWeatherLabel.text = "\(self.forecastday!.day.condition.text)"
                // icon URL에서 파일명 추출
                let iconUrlString = self.forecastday!.day.condition.icon
                let iconFilename = (iconUrlString as NSString).lastPathComponent // 예: "113.png"
                let iconName = (iconFilename as NSString).deletingPathExtension // 예: "113"
                // 애셋에서 이미지 로드
                self.yesterdayweatherImageView.image = UIImage(named: iconName)
            }
        }
        task.resume()
        featchWeatherData()
    }
    //오늘날씨데이터 가져오기
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
            todayTemperatureLabel.text = "\(Int(main!.temp))º"
            todayWeatherLabel.text = "\(weather!.description)"
            todayweatherImageView.image = UIImage(named: weather!.icon)
            todayHighLoweLabel.text = "\(Int(main!.tempmax))º \(Int(main!.tempmin))º"
        }
}
//MARK: - 단위변경
extension WeatherDisplayViewController {
    
    func updateTemperatureLabel(unit: String) {
        if unit == "ºC"  {
            todayTemperatureLabel.text = "\(Int(main!.temp))º"
            yesterdayTemperatureLabel.text = "\(Int(forecastday!.day.avgtempC))º"
        } else {
            let temperatureInFahrenheit = Int(main!.temp * 9 / 5 + 32)
            let yesterdayTemperatureInFahrenheit = Int(forecastday!.day.avgtempC * 9 / 5 + 32)
            todayTemperatureLabel.text = "\(temperatureInFahrenheit)º"
            yesterdayTemperatureLabel.text = "\(yesterdayTemperatureInFahrenheit)º"
        }
    }
}
