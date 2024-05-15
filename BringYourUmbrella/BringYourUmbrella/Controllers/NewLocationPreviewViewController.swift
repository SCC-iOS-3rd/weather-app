//
//  NewLocationPreviewViewController.swift
//  BringYourUmbrella
//
//  Created by 희라 on 5/13/24.
//

// ⭐️ 장소검색>테이블뷰셀 탭 했을 때 뜨는 미리보기 페이지 ⭐️

import UIKit
import SnapKit

class NewLocationPreviewViewController: BaseViewController {
    
   // MARK: - 프로퍼티
    //api
    let weatherService = WeatherService()
    
    //위도와 경도
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    // 받아온 데이터를 저장할 프로퍼티
    var weather: Weather?
    var main: Main?
    var sys: Sys?
    var name: String?
    
    //메인페이지 구성요소
    //1.상단 ui (프리뷰페이지라 기능 제외)
    let viewStackView = UIStackView()
    
    let umbrellaImage = UIImageView() //LOGO
    let nameLabel = UILabel() //"우산챙겨"
    let timeLabel = UILabel() //"5/13 (월) 11:44 AM"
    
    let buttonStackView = UIStackView()
    let plusButton = UIButton()
    let alarmButton = UIButton()
    let temperatureButton = UIButton()
    
    let locationLabel = UILabel() // 현재 위치
    
    //2.날씨정보 뷰 ui
    //views
    var iconImageView = UIImageView() //썬 이미지에서 변경
    let todayWeatherView = UIView() //첫 번째 뷰
    let highloweTemperatureView = UIView() //두 번째 뷰
    let styleView = UIView() //세 번째 뷰
    let weatherDescriptionView = UIView() //네 번째 뷰
    
    //Labels
    let todayWeatherViewLabel = UILabel() //첫 번째 뷰
    let temperatureLabel = UILabel() //첫 번째 뷰
    let highloweViewLabel = UILabel() //두 번째 뷰
    let styleViewLabel = UILabel() //세 번째 뷰
    let weatherDescriptionViewLabel = UILabel() //네 번째 뷰
    
    //3. 플로팅 버튼
    let addNewLocationButton = UIButton()
     
    
   // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    

    // MARK: - setWeatherUI
    
    private func setWeatherUI() {
        let url = URL(string: "https://openweathermap.org/img/wn/\(self.weather?.icon ?? "00")@2x.png")
        let data = try? Data(contentsOf: url!)
        if let data = data {
            iconImageView.image = UIImage(data: data)
        }
        todayWeatherViewLabel.text = "\(weather!.description)"
        temperatureLabel.text = "\(main!.temp)º"
        highloweViewLabel.text = "최고 \(main!.tempmax)º ~ 최저 \(main!.tempmin)º"
    }//func setWeatherUI()
    
    
    //MARK: - 레이아웃, addSubview
    
    override func setupConstraints() {
        [umbrellaImage, nameLabel, buttonStackView, timeLabel, locationLabel, todayWeatherView, highloweTemperatureView, styleView, weatherDescriptionView, addNewLocationButton].forEach {
            view.addSubview($0)
        }
        [temperatureButton, alarmButton, plusButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        [todayWeatherViewLabel, temperatureLabel].forEach {
            viewStackView.addArrangedSubview($0)
        }
        [iconImageView, viewStackView].forEach { // 썬 이미지에서 변경
            todayWeatherView.addSubview($0)
        }
        highloweTemperatureView.addSubview(highloweViewLabel)
        styleView.addSubview(styleViewLabel)
        weatherDescriptionView.addSubview(weatherDescriptionViewLabel)
        
        umbrellaImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(30)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(umbrellaImage.snp.trailing).offset(10)
        }
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalToSuperview().offset(-30)
        }
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(umbrellaImage.snp.bottom).offset(23)
            $0.leading.equalToSuperview().offset(20)
        }
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        todayWeatherView.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.equalTo(200)
        }
        highloweTemperatureView.snp.makeConstraints {
            $0.top.equalTo(todayWeatherView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.equalTo(225)
        }
        styleView.snp.makeConstraints {
            $0.top.equalTo(highloweTemperatureView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.equalTo(235)
        }
        weatherDescriptionView.snp.makeConstraints {
            $0.top.equalTo(styleView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.equalTo(250)
        }
        viewStackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview().offset(50)
        }
        highloweViewLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        styleViewLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        weatherDescriptionViewLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        iconImageView.snp.makeConstraints { // 썬 이미지에서 변경
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(viewStackView.snp.leading)
            $0.centerY.equalToSuperview()
        }
        addNewLocationButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
            make.height.equalTo(47)
        }
    }
    
    //MARK: - UI 속성
    
    override func configureUI() {
        view.backgroundColor = UIColor(red: 0.4039, green: 0.7765, blue: 0.8902, alpha: 1)
        umbrellaImage.image = UIImage(named: "umbrella")
        
        buttonStackView.spacing = 15
        viewStackView.spacing = 3
        viewStackView.distribution = .fill
        styleView(todayWeatherView)
        styleView(highloweTemperatureView)
        styleView(styleView)
        styleView(weatherDescriptionView)
        nameLabel.text = "우산 챙겨"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        nameLabel.textColor = .white
        timeLabel.text = "5/13 (월) 11:44 AM"
        timeLabel.textColor = .white
        locationLabel.text = "현재 위치"
        locationLabel.textColor = .white
        locationLabel.font = UIFont.boldSystemFont(ofSize: 20)
        temperatureButton.setTitle("ºC", for: .normal)
        temperatureButton.setTitleColor(.white, for: .normal)
        alarmButton.setImage(UIImage(systemName: "bell.badge"), for: .normal)
        alarmButton.tintColor = .white
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.tintColor = .white
        
        // 날씨 정보 label
        //1. 오늘의 날씨
        iconImageView.image = UIImage(named: "sun") //
        iconImageView.contentMode = .scaleAspectFit
        todayWeatherViewLabel.text = "비온뒤갬"
        temperatureLabel.text = "22º"
        //2. 최고/최저 기온
        highloweViewLabel.text = "최고, 최저기온"
        //3. 미정
        styleViewLabel.text = "스타일추천?"
        //4. 추천문구
        weatherDescriptionViewLabel.text = "야외 활동이 잘 어울리는 날씨에오"
        //프리뷰 페이지 > 액션 제외
        
        addNewLocationButton.backgroundColor = .black
        addNewLocationButton.layer.cornerRadius = 10
        addNewLocationButton.setTitle("추가", for: .normal)
        addNewLocationButton.setTitleColor(.white, for: .normal)
        addNewLocationButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        addNewLocationButton.addTarget(self, action: #selector(addNewLocationButtonMove), for: .touchUpInside)
    }
    
    //뷰 스타일 통일
    func styleView(_ view: UIView, backgroundColor: UIColor = .white, cornerRadius: CGFloat = 10) {
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
    }
    
    @objc func addNewLocationButtonMove() {
        let mainPageVC = ViewController()
        //self.navigationController?.pushViewController(mainPageVC, animated: true)
        let navigationController = UINavigationController(rootViewController: mainPageVC)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    

}

