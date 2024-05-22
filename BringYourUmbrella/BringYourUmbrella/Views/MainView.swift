//
//  MainView.swift
//  BringYourUmbrella
//
//  Created by Kinam on 5/20/24.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    let umbrellaImage = UIImageView()
    let plusButton = NoHighlightButton(type: .system)
    let alarmButton = NoHighlightButton(type: .system)
    let temperatureButton = UIButton()
    let buttonStackView = UIStackView()
    let todayWeatherStackView = UIStackView()
    let nameLabel = UILabel()
    let timeLabel = UILabel()
    let locationLabel = UILabel()
    let todayWeatherViewLabel = UILabel()
    let temperatureLabel = UILabel()
    let highloweViewLabel = UILabel()
    let styleViewLabel = UILabel()
    let weatherDescriptionViewLabel = UILabel()
    let iconImageView = UIImageView()
    let todayWeatherView = UIView()
    let highloweTemperatureView = UIView()
    let styleView = UIView()
    let weatherDescriptionView = UIView()
    let alphaView = UIView()
    let weatherIndicationView = UIView()
    let yesterdayLabel = UILabel()
    let todayLabel = UILabel()
    let chartViewYesterdayView = UIView()
    let chartViewTodayView = UIView()
    let yesterdayWeatherLabel = UILabel()
    let todayWeatherLabel = UILabel()
    let yesterdayHighLowehLabel = UILabel()
    let todayHighLoweLabel = UILabel()
    let yesterdayTemperatureLabel = UILabel()
    let todayTemperatureLabel = UILabel()
    let yesterdayweatherImageView = UIImageView()
    let todayweatherImageView = UIImageView()
    let navigationView = UIView()
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [].forEach {
            navigationView.addSubview($0)
        }
        [umbrellaImage, nameLabel, buttonStackView, timeLabel, locationLabel, todayWeatherView, highloweTemperatureView, styleView, weatherDescriptionView].forEach {
            addSubview($0)
        }
        [temperatureButton, alarmButton, plusButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        [todayWeatherViewLabel, temperatureLabel].forEach {
            todayWeatherStackView.addArrangedSubview($0)
        }
        [iconImageView, todayWeatherStackView].forEach {
            todayWeatherView.addSubview($0)
        }
        highloweTemperatureView.addSubview(highloweViewLabel)
        styleView.addSubview(styleViewLabel)
        weatherDescriptionView.addSubview(weatherDescriptionViewLabel)
    }
    
    private func setupConstraints() {
        // Umbrella Image
        umbrellaImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(30)
        }
        // "우산 챙겨" Label
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.leading.equalTo(umbrellaImage.snp.trailing).offset(10)
        }
        // Button Stack View
        buttonStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(55)
            $0.trailing.equalToSuperview().offset(-30)
        }
        // Time Label
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(umbrellaImage.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(20)
        }
        // Location Label
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(20)
        }
        // Today Weather View
        todayWeatherView.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.greaterThanOrEqualTo(todayWeatherStackView.snp.width).offset(20)
        }
        // High-Low Temperature View
        highloweTemperatureView.snp.makeConstraints {
            $0.top.equalTo(todayWeatherView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.greaterThanOrEqualTo(highloweViewLabel.snp.width).offset(20)
        }
        // Style View
        styleView.snp.makeConstraints {
            $0.top.equalTo(highloweTemperatureView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.greaterThanOrEqualTo(styleViewLabel.snp.width).offset(20)
        }
        // Weather Description View
        weatherDescriptionView.snp.makeConstraints {
            $0.top.equalTo(styleView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.greaterThanOrEqualTo(weatherDescriptionViewLabel.snp.width).offset(20)
        }
        // Today Weather Stack View
        todayWeatherStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 10))
        }
        // Icon Image View
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.verticalEdges.equalToSuperview().inset(15)
            $0.trailing.equalTo(todayWeatherStackView.snp.leading)
            $0.centerY.equalToSuperview()
        }
        // High-Low View Label
        highloweViewLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        // Style View Label
        styleViewLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        // Weather Description View Label
        weatherDescriptionViewLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
    }
    
    private func configureUI() {
        backgroundColor = UIColor(red: 0.4039, green: 0.7765, blue: 0.8902, alpha: 1)
        umbrellaImage.image = UIImage(systemName: "umbrella")
        umbrellaImage.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fill
        todayWeatherStackView.spacing = 10
        todayWeatherStackView.distribution = .equalSpacing
        styleView(todayWeatherView)
        styleView(highloweTemperatureView)
        styleView(styleView)
        styleView(weatherDescriptionView)
        nameLabel.text = "우산 챙겨"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        nameLabel.textColor = .white
        timeLabel.textColor = .white
        locationLabel.text = "현재 위치"
        locationLabel.textColor = .white
        locationLabel.font = UIFont.boldSystemFont(ofSize: 20)
        temperatureButton.setTitle("ºC", for: .normal)
        temperatureButton.setTitleColor(.white, for: .normal)
        temperatureButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        alarmButton.setImage(UIImage(systemName: "bell.badge"), for: .normal)
        alarmButton.tintColor = .white
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.tintColor = .white
        todayWeatherViewLabel.text = "지역을 찾고 있어요"
        highloweViewLabel.text = "최고 ~ 최저기온"
        styleViewLabel.text = "날씨에 따른 스타일을 추천해 드릴게요"
        weatherDescriptionViewLabel.text = "날씨에 따른 정보를 제공해드릴게요"
        alphaView.backgroundColor = .black
        alphaView.alpha = 0
    }
    
    private func styleView(_ view: UIView, backgroundColor: UIColor = .white, cornerRadius: CGFloat = 10) {
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
    }
}

