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
    //위도 경도
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    // MARK: - UI properties
    private let temperatureLabel : UILabel = {
        let label = UILabel()
        label.text = "24º" // 현재 온도
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

    private let maxBarHeight: CGFloat = 100
    private let minBarHeight: CGFloat = 30
    
    let barSection: UIView = {
        let bs = UIView()
        bs.backgroundColor = .clear
        return bs
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
        self.contentView.backgroundColor = .white
    }
    
    private func configureConstraints() {
        [temperatureLabel, barSection, weatherImageView, timePassageLabel].forEach {
            addSubview($0)
        }
        self.barSection.addSubview(barGraphView)
        
        timePassageLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
        weatherImageView.snp.makeConstraints {
            $0.bottom.equalTo(timePassageLabel.snp.top).offset(-8)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(25)
        }

        barSection.snp.makeConstraints {
            $0.bottom.equalTo(weatherImageView.snp.top).offset(-8)
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(8)
//            $0.height.equalTo(100)
        }
        temperatureLabel.snp.makeConstraints {
            $0.bottom.equalTo(barGraphView.snp.top).offset(-8)
            $0.centerX.equalToSuperview()
        }
    }

    
    // MARK: - methods
    func hourlyConfigureCell(with weatherEntry: WeatherEntry) {
        temperatureLabel.text = "\(Int(weatherEntry.main.temp))º"
        weatherImageView.image = UIImage(named: weatherEntry.weather.first!.icon)
        timePassageLabel.text = formatDateString(weatherEntry.dt_txt)
        
        if let maxTemperature = Double(exactly: weatherEntry.main.temp) {
            graphHeightControl(CGFloat(maxTemperature))
        }
    }
    
    func formatDateString(_ dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH시"
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func graphHeightControl(_ temperature: CGFloat) {
        let height = minBarHeight + (maxBarHeight - minBarHeight) * (temperature / 50)
        
        barGraphView.snp.makeConstraints {
            $0.bottom.equalTo(barSection.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(barSection.snp.width)
            $0.height.equalTo(height)
        }
    }
    

    
}
