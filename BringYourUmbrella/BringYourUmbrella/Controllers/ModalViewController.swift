//
//  ModalViewController.swift
//  BringYourUmbrella
//
//  Created by Hee  on 5/14/24.
//

import UIKit
import SnapKit

//모달창 프로퍼티
protocol BullletinDelegate: AnyObject {
    func onTapClose()
    func didChangeTemperature(unit: String)
}

class ModalViewController: BaseViewController {
    
    weak var delegate: BullletinDelegate?
    
    let tableView = UITableView()
    let modalView = UIView()
    let closeButton = UIButton()
    let temperatureSettingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: - 제약잡기
    override func setupConstraints() {
        [modalView, closeButton, temperatureSettingLabel,tableView].forEach {
            view.addSubview($0)
        }
        modalView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(200)
        }
        closeButton.snp.makeConstraints {
            $0.top.equalTo(modalView.snp.top).offset(10)
            $0.trailing.equalTo(modalView.snp.trailing).offset(-20)
            $0.height.width.equalTo(25)
        }
        temperatureSettingLabel.snp.makeConstraints {
            $0.top.equalTo(modalView.snp.top).offset(15)
            $0.leading.equalTo(modalView.snp.leading).offset(20)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(temperatureSettingLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(modalView.snp.horizontalEdges)
            $0.height.equalTo(200)
            }
    }
    //MARK: - UI속성
    override func configureUI() {
        tableviewProperty()
        modalView.backgroundColor = .white
        modalView.layer.cornerRadius = 20
        closeButton.setImage(UIImage(named: "xmark"), for: .normal)
        closeButton.addTarget(self, action: #selector(onTapClose), for: .touchUpInside)
        closeButton.tintColor = .black
        temperatureSettingLabel.text = "온도 설정"
        temperatureSettingLabel.font = UIFont.boldSystemFont(ofSize: 20)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 0)
    }
    //테이블뷰 기본설정
    func tableviewProperty() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ModalTableViewCell.self, forCellReuseIdentifier: ModalTableViewCell.identifier)
    }
    //모달창설정
    static func instance() -> ModalViewController {
        let viewController = ModalViewController(nibName: nil, bundle: nil)
        viewController.modalPresentationStyle = .overFullScreen
        return viewController
    }
    @objc func onTapClose() {
        delegate?.onTapClose()
        dismiss(animated: true)
    }
}
//MARK: - 테이블뷰설정
extension ModalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ModalCell", for: indexPath) as! ModalTableViewCell
        switch indexPath.row {
        case 0:
            cell.celsiusLabel.text = "ºC(섭씨온도)"
        case 1:
            cell.fahrenheitLabel.text = "ºF(화씨온도)"
        default:
            break
        }
        cell.checkButton.isHidden = true
        return cell
    }
    // 원하는 셀 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 60
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if let cell = tableView.cellForRow(at: indexPath) as? ModalTableViewCell {
               cell.checkButton.isHidden = false
               let selectedUnit = indexPath.row == 0 ? "ºC" : "ºF"
               delegate?.didChangeTemperature(unit: selectedUnit)
           }
       }

       func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
           if let cell = tableView.cellForRow(at: indexPath) as? ModalTableViewCell {
               cell.checkButton.isHidden = true
           }
       }
    
}
