//
//  WeeklyWeatherCollectionViewCell.swift
//  BringYourUmbrella
//
//  Created by Kinam on 5/22/24.
//

import UIKit
import SnapKit

class WeeklyWeatherCollectionViewCell: UICollectionViewCell {
    
    // MARK: - properties
    static let identifier = String(describing: WeeklyWeatherCollectionViewCell.self)
    
    //api
    let weatherService = WeatherService()
    var weather: Weather?
    var sys: Sys?
    var main: Main?
    var name: String?
    //위도 경도
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    private let maxBarHeight: CGFloat = 100
    private let minBarHeight: CGFloat = 20
    
    let daysLabel: UILabel = {
        let tl = UILabel()
        tl.text = "오늘"
        tl.textColor = .black
        tl.font = .systemFont(ofSize: 9, weight: .light)
        return tl
    }()
    
    let datesLabel: UILabel = {
        let tl = UILabel()
        tl.text = "5.13"
        tl.textColor = .black
        tl.font = .systemFont(ofSize: 9, weight: .light)
        return tl
    }()
    
    let maxTemp: UILabel = {
        let tl = UILabel()
        tl.text = "24º"
        tl.textColor = .black
        tl.font = .systemFont(ofSize: 15, weight: .semibold)
        return tl
    }()
    
    let minTemp: UILabel = {
        let tl = UILabel()
        tl.text = "22º"
        tl.textColor = .black
        tl.font = .systemFont(ofSize: 15, weight: .semibold)
        return tl
    }()
    
    let cellBar: UIView = {
        let cb = UIView()
        cb.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        cb.layer.cornerRadius = 4
        return cb
    }()
    
    let barSection: UIView = {
        let bs = UIView()
        bs.backgroundColor = .clear
        return bs
    }()
    
    // MARK: - methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.contentView.backgroundColor = .white
    }
    
    private func setConstraints() {
        [daysLabel, datesLabel, maxTemp, barSection, minTemp].forEach {
            self.contentView.addSubview($0)
        }
        
        self.barSection.addSubview(cellBar)
        
        daysLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(8)
        }
        
        datesLabel.snp.makeConstraints {
            $0.top.equalTo(daysLabel.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(8)
        }
        
        maxTemp.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(datesLabel.snp.bottom).offset(4)
            $0.bottom.lessThanOrEqualTo(cellBar.snp.top).offset(-1)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        barSection.snp.makeConstraints {
            $0.top.equalTo(maxTemp.snp.bottom).offset(3)
            $0.bottom.equalTo(minTemp.snp.top).inset(-3)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(8)
        }
        
        minTemp.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
    }
    
    func weeklyConfigureCell(with forecastDay: ForecastDay) {
        daysLabel.text = dayOfWeek(from: forecastDay.date)
        datesLabel.text = formatDateString(forecastDay.date)
        maxTemp.text = "\(Int(forecastDay.day.maxtempC))º"
        minTemp.text = "\(Int(forecastDay.day.mintempC))º"
        
        if let maxTemperature = Double(exactly: forecastDay.day.maxtempC) {
            updateCellBarHeight(CGFloat(maxTemperature))
        }
        
    }
    
    func formatDateString(_ dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "M.dd"
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func dayOfWeek(from dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "E"  // 'E' stands for day of the week abbreviation
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func updateCellBarHeight(_ temperature: CGFloat) {
        let height = minBarHeight + (maxBarHeight - minBarHeight) * (temperature / 50.0)
        cellBar.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(barSection.snp.bottom)
            $0.width.equalTo(barSection.snp.width)
            $0.height.equalTo(height)
        }
    }
}
