
import UIKit
import SnapKit

//메인페이지
class ViewController: BaseViewController {
    
    let umbrellaImage = UIImageView()
    let plusButton = UIButton()
    let alarmButton = UIButton()
    let temperatureButton = UIButton()
    let buttonStackView = UIStackView()
    let viewStackView = UIStackView()
    let nameLabel = UILabel()
    let timeLabel = UILabel()
    let locationLabel = UILabel()
    //뷰안에들은 Label들
    let todayWeatherViewLabel = UILabel()
    let temperatureLabel = UILabel()
    let highloweViewLabel = UILabel()
    let styleViewLabel = UILabel()
    let weatherDescriptionViewLabel = UILabel()
    //가운데view
    let sunImage = UIImageView()
    let todayWeatherView = UIView()
    let highloweTemperatureView = UIView()
    let styleView = UIView()
    let weatherDescriptionView = UIView()
    //모달창부분
    let alphaView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK: - 오토레이아웃
    override func setupConstraints() {
        [umbrellaImage, nameLabel, buttonStackView, timeLabel, locationLabel, todayWeatherView, highloweTemperatureView, styleView, weatherDescriptionView].forEach {
            view.addSubview($0)
        }
        [temperatureButton, alarmButton, plusButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        [todayWeatherViewLabel, temperatureLabel].forEach {
            viewStackView.addArrangedSubview($0)
        }
        [sunImage, viewStackView].forEach {
            todayWeatherView.addSubview($0)
        }
        highloweTemperatureView.addSubview(highloweViewLabel)
        styleView.addSubview(styleViewLabel)
        weatherDescriptionView.addSubview(weatherDescriptionViewLabel)
        
        umbrellaImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(30)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(umbrellaImage.snp.trailing).offset(10)
        }
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalToSuperview().offset(-30)
        }
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(umbrellaImage.snp.bottom).offset(23)
            $0.leading.equalToSuperview().offset(20)
        }
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        todayWeatherView.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.equalTo(200)
        }
        highloweTemperatureView.snp.makeConstraints {
            $0.top.equalTo(todayWeatherView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.equalTo(225)
        }
        styleView.snp.makeConstraints {
            $0.top.equalTo(highloweTemperatureView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.equalTo(235)
        }
        weatherDescriptionView.snp.makeConstraints {
            $0.top.equalTo(styleView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.equalTo(250)
        }
        viewStackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview().offset(50)
        }
        highloweViewLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        styleViewLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        weatherDescriptionViewLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        sunImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
    }
    //MARK: - UI속성
    override func configureUI() {
        view.backgroundColor = UIColor(red: 0.4039, green: 0.7765, blue: 0.8902, alpha: 1)
        umbrellaImage.image = UIImage(named: "umbrella")
        sunImage.image = UIImage(named: "sun")
        buttonStackView.spacing = 15
        viewStackView.spacing = 3
        viewStackView.distribution = .fill
        styleView(todayWeatherView)
        styleView(highloweTemperatureView)
        styleView(styleView)
        styleView(weatherDescriptionView)
        nameLabel.text = "우산 챙겨"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        nameLabel.textColor = .white
        timeLabel.text = "5/13 (월) 11:44 AM"
        timeLabel.textColor = .white
        locationLabel.text = "현재 위치"
        locationLabel.textColor = .white
        locationLabel.font = UIFont.boldSystemFont(ofSize: 20)
        temperatureButton.setTitle("ºC", for: .normal)
        temperatureButton.setTitleColor(.white, for: .normal)
        alarmButton.setImage(UIImage(systemName: "bell.badge"), for: .normal)
        alarmButton.tintColor = .white
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.tintColor = .white
        todayWeatherViewLabel.text = "비온뒤갬"
        temperatureLabel.text = "22º"
        highloweViewLabel.text = "최고, 최저기온"
        styleViewLabel.text = "스타일추천?"
        weatherDescriptionViewLabel.text = "야외 활동이 잘 어울리는 날씨에오"
        alphaView.backgroundColor = .black
        alphaView.alpha = 0
        temperatureButton.addTarget(self, action: #selector(temperatureChange), for: .touchUpInside)
        alarmButton.addTarget(self, action: #selector(alarmButtonMove), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonMove), for: .touchUpInside)
    }
}
//MARK: - 알람,플러스 버튼 화면이동
extension ViewController {
    
    @objc func alarmButtonMove() {
//        let alarmVC =
//        alarmVC.delegate = self
//        present(alarmVC, animated: true)
    }
    @objc func plusButtonMove () {
//        let plusVC =
//        plusVC.delegate = self
//        present(alarmVC, animated: true)
    }
}
//MARK: - 단위변경 모달창
extension ViewController: BullletinDelegate {
    //view의 색상,코너값
    func styleView(_ view: UIView, backgroundColor: UIColor = .white, cornerRadius: CGFloat = 10) {
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
    }
    //단위변경모달창작업
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


