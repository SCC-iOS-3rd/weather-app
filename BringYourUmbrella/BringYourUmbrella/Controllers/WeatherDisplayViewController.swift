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
    var forecastday: ForecastDay?
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
    
    var yesterdayTemperature: Double = 0.0
    var todayTemperature:Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchyesterdayweather()
        yesterdayDate()
    }
   
    
    //MARK: - 오토레이아웃
    override func setupConstraints() {
        [weatherIndicationView, yesterdayLabel, todayLabel].forEach {
            view.addSubview($0)
        }
        [yesterdayWeatherLabel, todayWeatherLabel, todayweatherImageView, todayHighLoweLabel, todayTemperatureLabel, yesterdayHighLowehLabel, yesterdayweatherImageView, yesterdayTemperatureLabel, chartViewTodayView, chartViewYesterdayView].forEach {
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
            $0.centerX.equalToSuperview().offset(55)
        }
        //오늘
        todayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview().offset(-55)
        }
        //어제날씨 표현
        yesterdayWeatherLabel.snp.makeConstraints {
            $0.bottom.equalTo(yesterdayHighLowehLabel.snp.top).offset(-5)
            $0.centerX.equalToSuperview().offset(-55)
        }
        //오늘날씨 표현
        todayWeatherLabel.snp.makeConstraints {
            $0.bottom.equalTo(todayHighLoweLabel.snp.top).offset(-5)
            $0.centerX.equalToSuperview().offset(55)
        }
        //어제날씨이미지
        yesterdayweatherImageView.snp.makeConstraints {
            $0.bottom.equalTo(yesterdayWeatherLabel.snp.top).offset(-5)
            $0.centerX.equalToSuperview().offset(-55)
            $0.width.height.equalTo(25)
        }
        //오늘날씨이미지
        todayweatherImageView.snp.makeConstraints {
            $0.bottom.equalTo(todayWeatherLabel.snp.top).offset(-5)
            $0.centerX.equalToSuperview().offset(55)
            $0.width.height.equalTo(25)
        }
        //어제최고~최저
        yesterdayHighLowehLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-40)
            $0.centerX.equalToSuperview().offset(-55)
            $0.centerY.equalToSuperview().offset(140)
        }
        //오늘최고~최저
        todayHighLoweLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-40)
            $0.centerX.equalToSuperview().offset(55)
            $0.centerY.equalToSuperview().offset(140)
        }
        //큰글씨오늘날씨
        todayTemperatureLabel.snp.makeConstraints {
            $0.bottom.equalTo(chartViewTodayView.snp.top)
            $0.centerX.equalToSuperview().offset(60)
        }
        //큰글씨어제날씨
        yesterdayTemperatureLabel.snp.makeConstraints {
            $0.bottom.equalTo(chartViewYesterdayView.snp.top)
            $0.centerX.equalToSuperview().offset(-50)
        }
        //얇은 차트 View
        chartViewTodayView.snp.makeConstraints {
            $0.top.equalTo(todayTemperatureLabel).offset(50)
            $0.bottom.equalTo(todayweatherImageView.snp.top).offset(-10)
            $0.centerX.equalToSuperview().offset(55)
            $0.width.equalTo(8)
            $0.height.equalTo(yesterdayTemperature>todayTemperature ? 100 : 80)
        }
        chartViewYesterdayView.snp.makeConstraints {
            $0.top.equalTo(yesterdayTemperatureLabel).offset(50)
            $0.bottom.equalTo(yesterdayweatherImageView.snp.top).offset(-10)
            $0.leading.equalToSuperview().offset(70)
            $0.width.equalTo(8)
            $0.height.equalTo(todayTemperature<yesterdayTemperature ? 80 : 100)
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
        chartViewTodayView.backgroundColor = UIColor(red: 0.8275, green: 0.8275, blue: 0.8275, alpha: 1)
        chartViewTodayView.layer.cornerRadius = 4
        chartViewYesterdayView.backgroundColor = UIColor(red: 0.8275, green: 0.8275, blue: 0.8275, alpha: 1)
        chartViewYesterdayView.layer.cornerRadius = 4
        todayTemperatureLabel.textAlignment = .center
        yesterdayTemperatureLabel.textAlignment = .center
    }
    //view의 색상,코너값
    func styleView(_ view: UIView, backgroundColor: UIColor = .white, cornerRadius: CGFloat = 10) {
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
    }
}
//MARK: - 어제,오늘 날씨데이터
extension WeatherDisplayViewController {
    
    func yesterdayDate() -> (String,String) {
        let now = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: now)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let yesterdayDate = dateFormatter.string(from: yesterday)
        dateFormatter.dateFormat = "HH"
        let currentHour = dateFormatter.string(from: now)
        print("전일자구하기",yesterdayDate, currentHour)
        return (yesterdayDate, currentHour)
    }
    
    //어제날씨데이터 가져오기
    func fetchyesterdayweather() {
        //어제의날짜,현재의시간가져오기
        let (yesterdayDate, currentHour) = yesterdayDate()
        guard let url = URL(string: "http://api.weatherapi.com/v1/history.json?key=c9b70526c91341798a493546241305&q=\(latitude),\(longitude)&dt=\(yesterdayDate)&hour=\(currentHour)&lang=ko") else { return }
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
                self.yesterdayTemperature = self.forecastday!.day.avgtempC
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
            todayTemperature = main!.temp
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
