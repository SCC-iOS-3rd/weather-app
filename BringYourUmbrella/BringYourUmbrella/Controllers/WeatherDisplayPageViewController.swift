//
//  WeatherDisplayPageViewController.swift
//  BringYourUmbrella
//
//  Created by Hee  on 5/13/24.
//

import UIKit
import SnapKit

//날씨 표시 페이지
class WeatherDisplayPageViewController: BaseViewController {
    
    let plusButton = UIButton()
    let alarmButton = UIButton()
    let temperatureButton = UIButton()
    let buttonStackView = UIStackView()
    let nameLabel = UILabel()
    let timeLabel = UILabel()
    let yesterdayWeatherLabel = UILabel()
    let todayWeatherLabel = UILabel()
    let todayLabel = UILabel()
    let yesterdayLabel = UILabel()
    let locationLabel = UILabel()
    let umbrellaImage = UIImageView()
    let rectangelView = UIView()
    let alphaView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: - 제약잡기
    override func setupConstraints() {
        [umbrellaImage, nameLabel, timeLabel, locationLabel,buttonStackView, rectangelView].forEach {
            view.addSubview($0)
        }
        [temperatureButton, alarmButton, plusButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        [todayLabel, yesterdayLabel, yesterdayWeatherLabel, todayWeatherLabel].forEach {
            rectangelView.addSubview($0)
        }
        umbrellaImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(30)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(umbrellaImage.snp.trailing).offset(10)
        }
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(umbrellaImage.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalToSuperview().offset(-30)
        }
        rectangelView.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(370)
            $0.width.equalTo(250)
        }
        todayLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-60)
            $0.top.equalToSuperview().offset(80)
        }
        yesterdayLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(60)
            $0.top.equalToSuperview().offset(80)
        }
        yesterdayWeatherLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(60)
            $0.top.equalToSuperview().offset(260)
        }
        todayWeatherLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-60)
            $0.top.equalToSuperview().offset(260)
        }
    }
    //MARK: - UI속성
    override func configureUI() {
        view.backgroundColor = UIColor(red: 0.4039, green: 0.7765, blue: 0.8902, alpha: 1)
        umbrellaImage.image = UIImage(named: "umbrella")
        rectangelView.backgroundColor = .white
        rectangelView.layer.cornerRadius = 10
        yesterdayLabel.text = "어제"
        yesterdayWeatherLabel.text = "안개"
        todayLabel.text = "오늘"
        todayWeatherLabel.text = "맑음"
        nameLabel.text = "우산 챙겨"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        nameLabel.textColor = .white
        timeLabel.text = datefunc()
        timeLabel.textColor = .white
        locationLabel.text = "서울"
        locationLabel.font = UIFont.boldSystemFont(ofSize: 20)
        locationLabel.textColor = .white
        buttonStackView.spacing = 15
        temperatureButton.setTitle("ºC", for: .normal)
        temperatureButton.setTitleColor(.white, for: .normal)
        alarmButton.setImage(UIImage(systemName: "bell.badge"), for: .normal)
        alarmButton.tintColor = .white
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.tintColor = .white
        alphaView.backgroundColor = .black
        alphaView.alpha = 0
        temperatureButton.addTarget(self, action: #selector(temperatureChange), for: .touchUpInside)
        alarmButton.addTarget(self, action: #selector(alarmButtonMove), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonMove), for: .touchUpInside)
        swipefunc() //오른쪽화면 스와이프 함수
    }
}
//MARK: - 알람,플러스 버튼 화면이동
extension WeatherDisplayPageViewController {
    //알람 화면이동
    @objc func alarmButtonMove (sender: UIButton) {
//        let alarmVC =
//        self.navigationController?.pushViewController(alarmVC, animated: true)
    }
    //위치추가 화면이동
    @objc func plusButtonMove (sender: UIButton) {
        let plusVC = LocationManagementViewContorller()
        self.navigationController?.pushViewController(plusVC, animated: true)
    }
    //스와이프 함수
    func swipefunc() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    //왼쪽 스와이프 이동 제스쳐
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            leftfunc()
            let mainVC = ViewController()
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    func leftfunc() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromRight
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
    }
}
//MARK: - 단위변경 모달창
extension WeatherDisplayPageViewController: BullletinDelegate {
    //단위변경모달창작업(ViewController와동일함)
    @objc func temperatureChange(sender: UIButton) {
        let modalVC = ModalViewController.instance()
        modalVC.delegate = self
        screenAlpha()
        present(modalVC, animated: true)
    }
    private func screenAlpha() {
        view.addSubview(alphaView)
        alphaView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
        DispatchQueue.main.async { [weak self] in
            self?.alphaView.alpha = 0.2
        }
    }
    private func removeAlpha() {
        DispatchQueue.main.async { [weak self] in
            self?.alphaView.removeFromSuperview()
        }
    }
    static func instance() -> ViewController {
        return ViewController(nibName: nil, bundle: nil)
    }
    func onTapClose() {
        self.removeAlpha()
    }
    func didChangeTemperature(unit: String) {
        temperatureButton.setTitle(unit, for: .normal)
    }
}
//MARK: - 시간만 표시
extension WeatherDisplayPageViewController {
    func datefunc() -> String {
        let date = Date()
        let dateFormatterKR = DateFormatter()
        dateFormatterKR.dateFormat = "HH:mm a"
        dateFormatterKR.timeZone = TimeZone(abbreviation: "KST")
        let datePart = dateFormatterKR.string(from: date)
        return datePart
    }
}
