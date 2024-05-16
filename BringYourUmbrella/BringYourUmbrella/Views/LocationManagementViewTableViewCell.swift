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
    
    let favoritesView: UIView = {
        let fv = UIView()
        fv.backgroundColor = .white
        fv.layer.cornerRadius = 12
        return fv
    }()
    
    let favoritesLocation: UILabel = {
        let cl = UILabel()
        cl.font = .systemFont(ofSize: 18, weight: .regular)
        cl.text = "강남구 논현동"
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
        ct.text = "20°C"
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
}