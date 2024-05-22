//
//  LocationManagementViewTableViewCell.swift
//  BringYourUmbrella
//
//  Created by Kinam on 5/14/24.
//

import UIKit
import SnapKit

class LocationManagementViewTableViewCell: UITableViewCell {
    
    // MARK: - properties
    static let identifier = String(describing: LocationManagementViewTableViewCell.self)
    let weatherService = WeatherService()
    var locationName: String = ""
    
    let favoritesView: UIView = {
        let fv = UIView()
        fv.backgroundColor = .white
        fv.layer.cornerRadius = 12
        return fv
    }()
    
    let favoritesLocation: UILabel = {
        let cl = UILabel()
        cl.font = .systemFont(ofSize: 18, weight: .regular)
        cl.text = ""
        return cl
    }()
    
    let favoritesWeatherImageView: UIImageView = {
        let wi = UIImageView()
        wi.image = UIImage(systemName: "sun.max.fill")
        return wi
    }()
    
    let favoritesTemperature: UILabel = {
        let ct = UILabel()
        ct.font = .systemFont(ofSize: 15, weight: .medium)
        ct.text = "00.00°C"
        return ct
    }()
    
    // MARK: - methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 12
    }
    
    private func setConstraints() {
        [favoritesView].forEach {
            self.contentView.addSubview($0)
        }
        
        [favoritesLocation, favoritesTemperature, favoritesWeatherImageView].forEach {
            self.favoritesView.addSubview($0)
        }
        
        favoritesView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView).inset(10)
            $0.verticalEdges.equalTo(contentView).inset(8)
        }
        
        favoritesLocation.snp.makeConstraints {
            $0.leading.equalTo(favoritesView.snp.leading).offset(15)
            $0.centerY.equalToSuperview()
        }
        
        favoritesTemperature.snp.makeConstraints {
            $0.trailing.equalTo(favoritesView.snp.trailing).inset(15)
            $0.centerY.equalTo(favoritesView)
        }
        
        favoritesWeatherImageView.snp.makeConstraints {
            $0.trailing.equalTo(favoritesTemperature.snp.leading).offset(-14)
            $0.centerY.equalTo(favoritesView)
            $0.width.height.equalTo(30)
        }
    }
    
    func updateWeather(for location: Location) {
        // 현재 위치명, 아이콘, 온도로 업데이트
        tranceAdministrativeArea(latitude: location.latitude, longitude: location.longitude) { locationName in
            DispatchQueue.main.async {
                self.favoritesLocation.text = locationName
            }
        }
        
        weatherService.getWeather(latitude: location.latitude, longitude: location.longitude) { result in
            switch result {
            case .success(let weatherResponse):
                let urlString = "https://openweathermap.org/img/wn/\(weatherResponse.weather.first?.icon ?? "00")@2x.png"
                guard let url = URL(string: urlString) else { return }
                
                URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async {
                    }
                }.resume()
                
                DispatchQueue.main.async {
                    if let image = UIImage(named: weatherResponse.weather.first!.icon) {
                        self.favoritesWeatherImageView.image = image
                    }
                    self.favoritesTemperature.text = "\(weatherResponse.main.temp)º"
                }
            case .failure(let error):
                print("Failed to fetch weather data: \(error)")
            }
        }
    }
}
