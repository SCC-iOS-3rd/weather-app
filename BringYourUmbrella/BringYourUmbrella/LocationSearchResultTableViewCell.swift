//
//  LocationSearchResultTableViewCell.swift
//  BringYourUmbrella
//
//  Created by t2023-m0114 on 5/13/24.
//

import UIKit

class LocationSearchResultTableViewCell: UITableViewCell {
    
    static let identifier = "SearchResultTableViewCell"
    
    let locationName = UILabel()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .gray
        
        [locationName].forEach {
            contentView.addSubview($0)
        }
        
        locationName.font = UIFont.systemFont(ofSize: 16)
        locationName.text = "지역 이름"
        locationName.textColor = .black
        locationName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
