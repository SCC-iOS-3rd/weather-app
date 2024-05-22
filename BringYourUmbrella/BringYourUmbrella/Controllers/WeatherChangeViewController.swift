//
//  WeatherChangeViewController.swift
//  BringYourUmbrella
//
//  Created by /Chynmn/M1 pro—̳͟͞͞♡ on 5/17/24.
//

import UIKit
import SnapKit

class WeatherChangeViewController : UIViewController {
    
    private let weatherChangeView = WeatherChangeView()
    //api
    let weatherService = WeatherService()
    var weather: Weather?
    var sys: Sys?
    var main: Main?
    var name: String?
    //위도 경도
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    
    override func loadView() {
        view = weatherChangeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }
    
    private func setCollectionView() {
        weatherChangeView.hourlyCollectionView.dataSource = self
        weatherChangeView.hourlyCollectionView.register(HourlyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.identifier)
        weatherChangeView.weeklyCollectionView.dataSource = self
        weatherChangeView.weeklyCollectionView.register(WeeklyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeeklyWeatherCollectionViewCell.identifier)
        weatherChangeView.hourlyCollectionView.tag = 1
        weatherChangeView.weeklyCollectionView.tag = 2
    }
    
    
}

extension WeatherChangeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if weatherChangeView.hourlyCollectionView.tag == 1 {
            return 7
        } else if weatherChangeView.hourlyCollectionView.tag == 2 {
            return 5
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if weatherChangeView.hourlyCollectionView.tag == 1 {
            guard let cell = weatherChangeView.hourlyCollectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.identifier, for: indexPath) as? HourlyWeatherCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        } else if weatherChangeView.hourlyCollectionView.tag == 2 {
            guard let cell = weatherChangeView.weeklyCollectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.identifier, for: indexPath) as? HourlyWeatherCollectionViewCell else { return UICollectionViewCell() }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension WeatherChangeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if weatherChangeView.hourlyCollectionView.tag == 1 {
            let width = weatherChangeView.hourlyCollectionView.bounds.width / 7
            let height = weatherChangeView.hourlyCollectionView.bounds.height
            return CGSize(width: width, height: height)
        } else if weatherChangeView.hourlyCollectionView.tag == 2 {
            let numberOfItemsPerRow: CGFloat = 5
            let spacing: CGFloat = (collectionView.bounds.width - (5 * 49)) / 6
            let width = (collectionView.bounds.width - (spacing * (numberOfItemsPerRow - 1))) / numberOfItemsPerRow
            let height = collectionView.bounds.height
            return CGSize(width: width, height: height)
        }
        return CGSize.zero
    }
}
