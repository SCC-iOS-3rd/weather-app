//
//  NewLocationPreviewViewController.swift
//  BringYourUmbrella
//
//  Created by 희라 on 5/13/24.
//

// ⭐️ 장소검색>추가 했을 때 미리보기 페이지 ⭐️

import UIKit

class NewLocationPreviewViewController: UIViewController {
    // 받아온 데이터를 저장할 프로퍼티
    var weather: Weather?
    var main: Main?
    var sys: Sys?
    var name: String?
    
    let PreviewtitleLabel = UILabel()
    
    var iconImageView = UIImageView()
    var tempLabel = UILabel()
    var maxTempLabel = UILabel()
    var minTempLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupTestVer()
        
        setupConstraints()
        configureUI()
        
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
    
    func setupConstraints() {
        [PreviewtitleLabel].forEach {
            view.addSubview($0)
        }
        
        PreviewtitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
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

    func configureUI() {
        PreviewtitleLabel.text = "새로운 장소 추가 프리뷰"
    }
    
}
