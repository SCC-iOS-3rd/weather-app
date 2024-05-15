//
//  ModalTableViewCell.swift
//  BringYourUmbrella
//
//  Created by Hee  on 5/14/24.
//

import UIKit
import SnapKit

//단위변경 모달창 테이블뷰셀
class ModalTableViewCell: UITableViewCell {

    let celsiusLabel = UILabel()
    let fahrenheitLabel = UILabel()
    let checkButton = UIButton()
    
    static let identifier = "ModalCell"
    
    //MARK: - 셀부분 오토레이아웃
    func setupConstraints () {
        [celsiusLabel, fahrenheitLabel, checkButton].forEach {
            contentView.addSubview($0)
        }
        celsiusLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().offset(15)
        }
        fahrenheitLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().offset(15)
        }
        checkButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().offset(-10)
        }
    }
    //MARK: - UI속성
    func configureUI() {
        checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        checkButton.tintColor = .black
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
