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
    let weatherService = WeatherService()
    
    // MARK: - UI properties
    private let temperatureLabel : UILabel = {
        let label = UILabel()
        label.text = "ºC" // 현재 온도
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private let barGraphView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.8275, green: 0.8275, blue: 0.8275, alpha: 1)
        return view
    }()
    
    private let weatherImageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let timePassageLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
//    private lazy var stackView : UIStackView = {
//        let stview = UIStackView(arrangedSubviews: [temperatureLabel, barGraphView, weatherImageView, timePassageLabel])
//        stview.spacing = 5
//        stview.axis = .vertical
//        stview.distribution = .fill
//        return stview
//    }()
    
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
        
    }
    
    private func configureConstraints() {
        [temperatureLabel, barGraphView, weatherImageView, timePassageLabel].forEach {
            addSubview($0)
        }
        timePassageLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        weatherImageView.snp.makeConstraints {
            $0.bottom.equalTo(timePassageLabel.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
        }
        barGraphView.snp.makeConstraints {
            $0.bottom.equalTo(weatherImageView.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(2)
            $0.height.equalTo(100)
        }
        temperatureLabel.snp.makeConstraints {
            $0.bottom.equalTo(barGraphView.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
        }
    }
    
//    private func graphHeightControl() {
//        switch barGraphView {
//
//        }
//    }
    
    // MARK: - methods

    
    
}
