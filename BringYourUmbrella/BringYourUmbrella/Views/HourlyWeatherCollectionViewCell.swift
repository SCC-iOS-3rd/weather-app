//
//  HourlyWeatherCollectionViewCell.swift
//  BringYourUmbrella
//
//  Created by /Chynmn/M1 pro—̳͟͞͞♡ on 5/21/24.
//

import UIKit
import SnapKit

class HourlyWeatherCollectionViewCell : UICollectionViewCell {
    
    static var identifier = String(describing: HourlyWeatherCollectionViewCell.self)
    //api
    let weatherService = WeatherService()
    var weather: Weather?
    var sys: Sys?
    var main: Main?
    var name: String?
    //위도 경도
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    // MARK: - UI properties
    private let temperatureLabel : UILabel = {
        let label = UILabel()
        label.text = "22º" // 현재 온도
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private let barGraphView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let weatherImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "01d")
        return imageView
    }()
    
    private let timePassageLabel : UILabel = {
        let label = UILabel()
        label.text = "지금"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.contentView.backgroundColor = .clear
    }
    
    private func configureConstraints() {
        [temperatureLabel, barGraphView, weatherImageView, timePassageLabel].forEach {
            addSubview($0)
        }
        timePassageLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-8)
            $0.centerX.equalToSuperview()
        }
        weatherImageView.snp.makeConstraints {
            $0.bottom.equalTo(timePassageLabel.snp.top).offset(-8)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(25)
        }
        barGraphView.snp.makeConstraints {
            $0.bottom.equalTo(weatherImageView.snp.top).offset(-8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(8)
            $0.height.equalTo(100)
        }
        temperatureLabel.snp.makeConstraints {
            $0.bottom.equalTo(barGraphView.snp.top).offset(-8)
            $0.centerX.equalToSuperview()
        }
    }

    
    // MARK: - methods
//    private func graphHeightControl() {
//        switch barGraphView {
//
//        }
//    }
    

    
}
