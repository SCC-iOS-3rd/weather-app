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
    
    let daysLabel: UILabel = {
        let tl = UILabel()
        tl.text = "오늘"
        tl.textColor = .black
        tl.font = .systemFont(ofSize: 8, weight: .light)
        return tl
    }()
    
    let datesLabel: UILabel = {
        let tl = UILabel()
        tl.text = "5.13"
        tl.textColor = .black
        tl.font = .systemFont(ofSize: 8, weight: .light)
        return tl
    }()
    
    let maxTemp: UILabel = {
        let tl = UILabel()
        tl.text = "24º"
        tl.textColor = .black
        tl.font = .systemFont(ofSize: 10, weight: .semibold)
        return tl
    }()
    
    let minTemp: UILabel = {
        let tl = UILabel()
        tl.text = "22º"
        tl.textColor = .black
        tl.font = .systemFont(ofSize: 10, weight: .semibold)
        return tl
    }()
    
    let cellBar: UIView = {
        let cb = UIView()
        cb.backgroundColor = UIColor(red: 0.8275, green: 0.8275, blue: 0.8275, alpha: 1)
        cb.layer.cornerRadius = 4
        return cb
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
        self.contentView.backgroundColor = .green
    }
    
    private func setConstraints() {
        [daysLabel, datesLabel, maxTemp, cellBar, minTemp].forEach {
            self.contentView.addSubview($0)
        }
        
        daysLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        datesLabel.snp.makeConstraints {
            $0.top.equalTo(daysLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        maxTemp.snp.makeConstraints {
            $0.bottom.equalTo(cellBar.snp.top).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        cellBar.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(minTemp.snp.top).offset(10)
        }
        
        minTemp.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
}
