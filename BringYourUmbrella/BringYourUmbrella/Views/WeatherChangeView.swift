//
//  WeatherChangeView.swift
//  BringYourUmbrella
//
//  Created by /Chynmn/M1 pro—̳͟͞͞♡ on 5/16/24.
//

import UIKit
//import Charts
import SnapKit

class WeatherChangeView : UIView {
    // MARK: - Location & Time
//    // 현재 사용자 위치
//    private let currentLocationLabel: UILabel = {
//        let label = UILabel()
//        label.text = "" // 현재 위치
//        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
//        return label
//    }()
//    
//    // 현재 위치의 시간
//    private let currentTimeLabel: UILabel = {
//        let label = UILabel()
//        label.text = "" // 현재 시간 Date()
//        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
//        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//        return label
//    }()
    private let weatherView = UIView()
    
    // MARK: - 시간대별 날씨(3h)
    lazy var hourlyCollectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 15 // cell사이의 간격 설정
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.isScrollEnabled = false
        return view
    }()
    
    private let hourlyWeatherLabel : UILabel = {
        let label = UILabel()
        label.text = "시간대별 날씨"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
//    private lazy var hourlyWeatherStackView: UIStackView = {
//        let stview = UIStackView()
//        stview.axis = .horizontal
//        stview.distribution = .fillEqually
//        stview.alignment = .fill
//        stview.spacing = 15
//        stview.addSubview(StackView)
//        return stview
//    }()
    
    private let divisionLineView = UIView()
    
    // MARK: - 주간 날씨(5d)
    private let weeklyWeatherLabel : UILabel = {
        let label = UILabel()
        label.text = "주간 날씨"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private lazy var weeklyWeatherStackView: UIStackView = {
        let stview = UIStackView()
        stview.axis = .horizontal
        stview.distribution = .fillEqually
        stview.alignment = .fill
        return stview
    }()
    
    
    
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        addViews()
        configureConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    }
    
    private func addViews() {
        [weatherView, hourlyWeatherLabel, divisionLineView, weeklyWeatherLabel].forEach {
            addSubview($0)
        }
        
    }
    
    private func configureConstraints() {
        hourlyWeatherViewConstraints()
        weeklyWeatherViewConstraints()
        
    }
    
    // MARK: - AutoLayout
    
    private func hourlyWeatherViewConstraints() {
        
    }
    
    private func weeklyWeatherViewConstraints() {
        
    }
    
//    private func Constraints() {
//        
//    }
    
    // MARK: - <#내용입력#>
    
    
    

}

// MARK: - Extension

extension WeatherChangeView {
    
    
    
//    #Preview {
//        WeatherChangeView()
//    }
}
