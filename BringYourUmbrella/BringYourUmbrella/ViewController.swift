//
//  ViewController.swift
//  BringYourUmbrella
//
//  Created by /Chynmn/M1 pro—̳͟͞͞♡ on 5/13/24.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    // 받아온 데이터를 저장할 프로퍼티
    var weather: Weather?
    var main: Main?
    var sys: Sys?
    var name: String?
    
    var iconImageView = UIImageView()
    var tempLabel = UILabel()
    var maxTempLabel = UILabel()
    var minTempLabel = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupTestVer()
        
        // data fetch
        WeatherService().getWeather { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self.weather = weatherResponse.weather.first
                    self.main = weatherResponse.main
                    self.name = weatherResponse.name
                    self.setWeatherUI()
                }
            case .failure(_ ):
                print("error")
            }
        }
    }
    
    private func setWeatherUI() {
        let url = URL(string: "https://openweathermap.org/img/wn/\(self.weather?.icon ?? "00")@2x.png")
        let data = try? Data(contentsOf: url!)
        if let data = data {
            iconImageView.image = UIImage(data: data)
        }

        tempLabel.text = "기온: \(main!.temp)"
        maxTempLabel.text = "최고기온: \(main!.tempmax)"
        minTempLabel.text = "최저기온: \(main!.tempmin)"
    }
    
    func setupTestVer() {
        [iconImageView, tempLabel, maxTempLabel, minTempLabel].forEach {
            view.addSubview($0)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(10)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        maxTempLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(220)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        minTempLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(240)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        
    }
    
}
