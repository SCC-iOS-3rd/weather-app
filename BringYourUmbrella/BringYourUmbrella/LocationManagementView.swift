//
//  LocationManagementView.swift
//  BringYourUmbrella
//
//  Created by Kinam on 5/13/24.
//

import UIKit
import SnapKit

class LocationManagementView: UIView {
    // MARK: - properties
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.text = "위치"
        tl.font = .systemFont(ofSize: 20, weight: .semibold)
        tl.textAlignment = .center
        return tl
    }()
    
    let currentLocationView: UIView = {
        let cl = UIView()
        cl.layer.cornerRadius = 12
        cl.backgroundColor = .white
        return cl
    }()
    
    let currentLocationLabel: UILabel = {
        let cll = UILabel()
        cll.font = .systemFont(ofSize: 18, weight: .regular)
        cll.text = "현재 위치"
        return cll
    }()
    
    let currentLocation: UILabel = {
        let cl = UILabel()
        cl.font = .systemFont(ofSize: 18, weight: .regular)
        cl.text = "강남구 논현동"
        return cl
    }()
    
    let currentLocationImageView: UIImageView = {
        let cliv = UIImageView()
        cliv.image = UIImage(systemName: "location.fill")
        return cliv
    }()
    
    let currentWeatherImageView: UIImageView = {
        let wi = UIImageView()
        wi.image = UIImage(systemName: "sun.max.fill")
        return wi
    }()
    
    let currentTemperature: UILabel = {
        let ct = UILabel()
        ct.font = .systemFont(ofSize: 15, weight: .medium)
        ct.text = "20°C"
        return ct
    }()
    
    let favoritesTableView: UITableView = {
        let ft = UITableView()
        ft.backgroundColor = .gray
        return ft
    }()
    
    let searchLocationView: UIView = {
        let sl = UIView()
        sl.backgroundColor = .lightGray
        return sl
    }()
    
    let searchButton: UIButton = {
        let sb = UIButton()
        sb.setTitle("위치 검색 및 추가", for: .normal)
        sb.backgroundColor = .white
        sb.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        return sb
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
    
    func setUI() {
        self.backgroundColor = .green
    }
    
    func setConstraints() {
        [titleLabel, currentLocationView].forEach {
            self.addSubview($0)
        }
        
        [currentLocationLabel, currentLocationImageView, currentLocation, currentWeatherImageView, currentTemperature].forEach {
            self.currentLocationView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
        }
    }
}
