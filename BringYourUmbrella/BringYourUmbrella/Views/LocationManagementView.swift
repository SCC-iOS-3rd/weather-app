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
        tl.font = .systemFont(ofSize: 22, weight: .bold)
        tl.textAlignment = .center
        tl.textColor = .white
        tl.sizeToFit()
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
        cl.text = "서울특별시 강남구"
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
        ft.backgroundColor = .clear
        ft.layer.cornerRadius = 12
        ft.separatorStyle = .none
        return ft
    }()
    
    let searchLocationView: UIView = {
        let sl = UIView()
        sl.backgroundColor = .lightGray
        return sl
    }()
    
    let favoritesLabel: UILabel = {
        let fl = UILabel()
        fl.font = .systemFont(ofSize: 20, weight: .bold)
        fl.textColor = .white
        fl.text = "즐겨찾기"
        return fl
    }()
    
    let favoritesEditButton: UIButton = {
        let feb = UIButton()
        feb.setTitle("편집", for: .normal)
        feb.setTitleColor(.white, for: .normal)
        feb.tintColor = .white
        feb.backgroundColor = .clear
        return feb
    }()
    
    let bottomView: UIView = {
        let bv = UIView()
        bv.backgroundColor = .lightGray
        bv.layer.cornerRadius = 12
        return bv
    }()
    
    let bottomSearchButton: UIButton = {
        let bsb = UIButton()
        bsb.setTitle("위치 검색 및 추가", for: .normal)
        bsb.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        bsb.tintColor = .black
        bsb.backgroundColor = .white
        bsb.setTitleColor(.black, for: .normal)
        bsb.layer.cornerRadius = 12
        return bsb
    }()
    
    let currentLocationButton: UIButton = {
        let clb = UIButton()
        clb.backgroundColor = .clear
        clb.tintColor = .clear
        clb.layer.cornerRadius = 12
        return clb
    }()
    
    let backButton: UIButton = {
        let bb = UIButton()
        bb.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        bb.tintColor = .white
        return bb
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
        self.backgroundColor = UIColor(red: 0.4039, green: 0.7765, blue: 0.8902, alpha: 1)
    }
    
    func setConstraints() {
        [titleLabel, backButton, currentLocationView, favoritesTableView, favoritesLabel, favoritesEditButton, bottomView, currentLocationButton].forEach {
            self.addSubview($0)
        }
        
        [currentLocationLabel, currentLocationImageView, currentLocation, currentWeatherImageView, currentTemperature].forEach {
            self.currentLocationView.addSubview($0)
        }
        
        [bottomSearchButton].forEach {
            self.bottomView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(60)
            $0.height.equalTo(40)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.height.equalTo(titleLabel.snp.height)
            $0.trailing.equalTo(titleLabel.snp.leading)
        }
        
        currentLocationView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(80)
        }
        
        currentLocationImageView.snp.makeConstraints {
            $0.leading.equalTo(currentLocationView.snp.leading).offset(14)
            $0.centerY.equalTo(currentLocationView)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        
        currentLocationLabel.snp.makeConstraints {
            $0.leading.equalTo(currentLocationImageView.snp.trailing).offset(8)
            $0.bottom.equalTo(currentLocationImageView.snp.centerY).offset(-2)
        }
        
        currentLocation.snp.makeConstraints {
            $0.top.equalTo(currentLocationImageView.snp.centerY).offset(2)
            $0.leading.equalTo(currentLocationLabel.snp.leading)
        }
        
        currentTemperature.snp.makeConstraints {
            $0.top.equalTo(currentLocationView.snp.top).offset(20)
            $0.leading.equalTo(currentLocationView.snp.trailing).inset(60)
            $0.centerY.equalTo(currentLocationView)
        }
        
        currentWeatherImageView.snp.makeConstraints {
            $0.trailing.equalTo(currentTemperature.snp.leading).offset(-10)
            $0.centerY.equalTo(currentLocationView)
            $0.width.height.equalTo(30)
        }
        
        favoritesLabel.snp.makeConstraints {
            $0.leading.equalTo(currentLocationView.snp.leading).offset(10)
            $0.top.equalTo(currentLocationView.snp.bottom).offset(90)
        }
        
        favoritesEditButton.snp.makeConstraints {
            $0.trailing.equalTo(currentLocationView.snp.trailing).inset(10)
            $0.top.equalTo(favoritesLabel.snp.top)
        }
        
        favoritesTableView.snp.makeConstraints {
            $0.top.equalTo(favoritesLabel.snp.bottom).offset(15)
            $0.horizontalEdges.equalTo(currentLocationView)
            $0.bottom.equalTo(bottomView.snp.top).offset(-10)
        }
        
        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(90)
        }
        
        bottomSearchButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(bottomView.snp.horizontalEdges).inset(20)
            $0.verticalEdges.equalTo(bottomView.snp.verticalEdges).inset(28)
        }
        
        currentLocationButton.snp.makeConstraints {
            $0.edges.equalTo(currentLocationView)
        }
    }
}
