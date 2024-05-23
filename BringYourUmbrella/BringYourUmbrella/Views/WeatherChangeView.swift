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
//    private let scrollView : UIScrollView = {
//       let scview = UIScrollView()
//        
//        return scview
//    }()
    
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
    
    // MARK: - 시간대별 날씨(3h)
    lazy var hourlyCollectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
//        flowLayout.minimumLineSpacing = 15 // cell사이의 간격 설정
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = UIColor(red: 0.8275, green: 0.8275, blue: 0.8275, alpha: 1)
        view.isScrollEnabled = false
        return view
    }()
    
    private let hourlyWeatherLabel : UILabel = {
        let label = UILabel()
        label.text = "시간대별 날씨"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let divisionLineView : UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    // MARK: - 주간 날씨(5d)
    private let weeklyWeatherLabel : UILabel = {
        let label = UILabel()
        label.text = "주간 날씨"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    lazy var weeklyCollectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 13 // cell사이의 간격 설정
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        return view
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
        [hourlyWeatherLabel, hourlyCollectionView, divisionLineView, weeklyWeatherLabel, weeklyCollectionView].forEach {
            addSubview($0)
        }
        hourlyWeatherLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
        }
        hourlyCollectionView.snp.makeConstraints {
            $0.top.equalTo(hourlyWeatherLabel.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(200)
            $0.width.equalTo(343)
        }
        divisionLineView.snp.makeConstraints {
            $0.top.equalTo(hourlyCollectionView.snp.bottom).offset(15)
            $0.height.equalTo(1)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        weeklyWeatherLabel.snp.makeConstraints {
            $0.top.equalTo(divisionLineView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
        }
        weeklyCollectionView.snp.makeConstraints {
            $0.top.equalTo(weeklyWeatherLabel.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(200)
            $0.width.equalTo(343)
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
    
    
    // MARK: - <#내용입력#>
    
    
    

}

// MARK: - Extension

extension WeatherChangeView {
    
    
    
//    #Preview {
//        WeatherChangeView()
//    }
}
