//
//  AlarmCell.swift
//  BringYourUmbrella
//
//  Created by 김준철 on 5/23/24.
//

import UIKit

class AlarmCell: UICollectionViewCell {
    var timeLabel: UILabel!
    var alarmSwitch: UISwitch!
    weak var delegate: AlarmCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupTimeLabel()
        setupalarmSwitch()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10.0 //모서리 둥글게
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    func setupViews(){
        timeLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 200, height: 30))
        alarmSwitch = UISwitch(frame: CGRect(x: self.frame.width - 60, y: 10, width: 50, height: 30))
        
        self.addSubview(timeLabel)
        self.addSubview(alarmSwitch)
        
       
        self.layer.masksToBounds = true
        
    }

    func setupTimeLabel() {
        timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 16)
        timeLabel.textColor = .black
        timeLabel.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(timeLabel)

        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
            // timeLabel의 trailingAnchor 제약 조건을 제거합니다.
        ])
    }

    func setupalarmSwitch() {
        alarmSwitch = UISwitch()
        alarmSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(alarmSwitch)
        
        NSLayoutConstraint.activate([
            alarmSwitch.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            alarmSwitch.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 10),
            alarmSwitch.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
        ])
        
        alarmSwitch.addTarget(self, action: #selector(alarmSwitchChanged(_:)), for: .valueChanged)
    }

    @objc func alarmSwitchChanged(_ sender: UISwitch) {
            delegate?.alarmSwitchDidChangeState(isOn: sender.isOn)
        }
     
    // UISwich의 상태 변경에 따른 필요 동작 추가 예정
    
}

protocol AlarmCellDelegate: AnyObject {
    func alarmSwitchDidChangeState(isOn: Bool)
}


