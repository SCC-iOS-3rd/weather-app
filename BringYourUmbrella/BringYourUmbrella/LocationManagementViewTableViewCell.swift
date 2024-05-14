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
        setConfigure()
        setUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
    }
    
    private func setConstraints() {
        [favoritesLocation, favoritesTemperature, favoritesWeatherImageView].forEach {
            self.contentView.addSubview($0)
        }
        
        favoritesLocation.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(15)
            $0.centerY.equalToSuperview()
        }
        
        favoritesTemperature.snp.makeConstraints {
            $0.trailing.equalTo(contentView.snp.trailing).inset(15)
        }
        
        favoritesWeatherImageView.snp.makeConstraints {
            $0.trailing.equalTo(favoritesTemperature.snp.leading).offset(14)
            $0.centerY.equalTo(contentView)
            $0.width.height.equalTo(30)
        }
    }
    
    func setConfigure() {
        
    }
    
}
