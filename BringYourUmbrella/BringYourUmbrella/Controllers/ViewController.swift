
import UIKit
import SnapKit
import CoreLocation

//메인페이지
class ViewController: BaseViewController {
    
    //현재위치 부분
    var locationManager = CLLocationManager()
 
    //api
    let weatherService = WeatherService()
    var weather: Weather?
    var sys: Sys?
    var main: Main?
    var name: String?
    
    //위도와 경도
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    //섭씨 화씨 변경 임의값 넣어둔것
    var temperatureInCelsius: Double = 0.0
    
    let umbrellaImage = UIImageView()
    let plusButton = NoHighlightButton(type: .system)
    let alarmButton = NoHighlightButton(type: .system)
    let temperatureButton = UIButton()
    let buttonStackView = UIStackView()
    let todayWeatherStackView = UIStackView()
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
    let iconImageView = UIImageView()
    let todayWeatherView = UIView()
    let highloweTemperatureView = UIView()
    let styleView = UIView()
    let weatherDescriptionView = UIView()
    //모달창부분
    let alphaView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationManager()
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
            todayWeatherStackView.addArrangedSubview($0)
        }
        [iconImageView, todayWeatherStackView].forEach {
            todayWeatherView.addSubview($0)
        }
        highloweTemperatureView.addSubview(highloweViewLabel)
        styleView.addSubview(styleViewLabel)
        weatherDescriptionView.addSubview(weatherDescriptionViewLabel)
        //우산이미지
        umbrellaImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(30)
        }
        //우산챙겨
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(umbrellaImage.snp.trailing).offset(10)
        }
        //단위변경,알람,위치추가 버튼 스택뷰
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalToSuperview().offset(-30)
        }
        //현재시각Label
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(umbrellaImage.snp.bottom).offset(23)
            $0.leading.equalToSuperview().offset(20)
        }
        //현재위치Label
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        //뷰 종류4가지 순서대로
        todayWeatherView.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.greaterThanOrEqualTo(todayWeatherStackView.snp.width).offset(20)
        }
        highloweTemperatureView.snp.makeConstraints {
            $0.top.equalTo(todayWeatherView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.greaterThanOrEqualTo(highloweViewLabel.snp.width).offset(20)
        }
        styleView.snp.makeConstraints {
            $0.top.equalTo(highloweTemperatureView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.greaterThanOrEqualTo(styleViewLabel.snp.width).offset(20)
        }
        weatherDescriptionView.snp.makeConstraints {
            $0.top.equalTo(styleView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(55)
            $0.width.greaterThanOrEqualTo(weatherDescriptionViewLabel.snp.width).offset(20)
        }
        //최상단 뷰안에 날씨+온도 스텍뷰
        todayWeatherStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 10))
        }
        //뷰 순서대로 Label
        highloweViewLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        styleViewLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        weatherDescriptionViewLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        //최상단 뷰의 날씨이미지
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.verticalEdges.equalToSuperview().inset(15)
            $0.trailing.equalTo(todayWeatherStackView.snp.leading)
            $0.centerY.equalToSuperview()
        }
    }
    //MARK: - UI속성
    override func configureUI() {
        view.backgroundColor = UIColor(red: 0.4039, green: 0.7765, blue: 0.8902, alpha: 1)
        self.navigationController?.isNavigationBarHidden = true
        umbrellaImage.image = UIImage(systemName: "umbrella")
        umbrellaImage.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fill
        todayWeatherStackView.spacing = 10
        todayWeatherStackView.distribution = .equalSpacing
        styleView(todayWeatherView)
        styleView(highloweTemperatureView)
        styleView(styleView)
        styleView(weatherDescriptionView)
        nameLabel.text = "우산 챙겨"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        nameLabel.textColor = .white
        timeLabel.text = datefunc()
        timeLabel.textColor = .white
        locationLabel.text = "현재 위치"
        locationLabel.textColor = .white
        locationLabel.font = UIFont.boldSystemFont(ofSize: 20)
        temperatureButton.setTitle("ºC", for: .normal)
        temperatureButton.setTitleColor(.white, for: .normal)
        temperatureButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        alarmButton.setImage(UIImage(systemName: "bell.badge"), for: .normal)
        alarmButton.tintColor = .white
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.tintColor = .white
        todayWeatherViewLabel.text = "지역을 찾고 있어요"
        highloweViewLabel.text = "최고 ~ 최저기온"
        styleViewLabel.text = "날씨에 따른 스타일을 추천해 드릴게요"
        weatherDescriptionViewLabel.text = "날씨에 따른 정보를 제공해드릴게요"
        alphaView.backgroundColor = .black
        alphaView.alpha = 0
        temperatureButton.addTarget(self, action: #selector(temperatureChange), for: .touchUpInside)
        alarmButton.addTarget(self, action: #selector(alarmButtonMove), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonMove), for: .touchUpInside)
        swipefunc() //왼쪽화면 스와이프 함수
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
    //단위 버튼타이틀 바뀌는함수
    func didChangeTemperature(unit: String) {
        temperatureButton.setTitle(unit, for: .normal)
        updateTemperatureLabel()
    }
    
    // 버튼에 맞게 섭씨/화씨 변경 뒤에 두자리까지 나오게
    func updateTemperatureLabel() {
        if temperatureButton.title(for: .normal) == "ºC" {
            temperatureLabel.text = String(format: "%.2fº", temperatureInCelsius)
        } else {
            let temperatureInFahrenheit = temperatureInCelsius * 9 / 5 + 32
            temperatureLabel.text = String(format: "%.2fº", temperatureInFahrenheit)
        }
    }
    
//    //버튼에맞게 섭씨화씨 변경부분
//    func updateTemperatureLabel() {
//        if temperatureButton.title(for: .normal) == "ºC" {
//            temperatureLabel.text = "\(Int(temperatureInCelsius))ºC"
//        } else {
//            let temperatureInFahrenheit = temperatureInCelsius * 9 / 5 + 32
//            temperatureLabel.text = "\(Int(temperatureInFahrenheit))ºF"
//        }
//    }
}
//MARK: - 시간표시
extension ViewController {

    func datefunc() -> String {
        let date = Date()
        let dateFormatterKR = DateFormatter()
        dateFormatterKR.dateFormat = "M/dd (E) HH:mm"
        dateFormatterKR.locale = Locale(identifier: "ko_KR")
        dateFormatterKR.timeZone = TimeZone(abbreviation: "KST")
        let datePart = dateFormatterKR.string(from: date)
        
        let dateFormatterDefault = DateFormatter()
        dateFormatterDefault.dateFormat = "a"
        dateFormatterDefault.timeZone = TimeZone(abbreviation: "KST")
        let dateDefault = dateFormatterDefault.string(from: date)
        
        let todayDate = "\(datePart) \(dateDefault)"
        return todayDate
    }
}
//MARK: - 알람,플러스,왼쪽스와이프 화면이동
extension ViewController {
    //알람 화면이동
    @objc func alarmButtonMove(sender: UIButton) {
        //        let alarmVC =
        //        present(alarmVC, animated: true)
    }
    //위치추가 화면이동
    @objc func plusButtonMove (sender: UIButton) {
        let plusVC = LocationManagementViewContorller()
        plusVC.latitude = latitude
        plusVC.longitude = longitude
        self.navigationController?.pushViewController(plusVC, animated: true)
    }

    //스와이프 함수
    func swipefunc() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    //왼쪽 스와이프 이동 제스쳐
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            rightfunc()
            let weatherVC = WeatherDisplayPageViewController()
            self.navigationController?.pushViewController(weatherVC, animated: true)
        }
    }
    func rightfunc() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
    }
    
}
//MARK: - 현재위치
extension ViewController: CLLocationManagerDelegate {

    private func setLocationManager() {
        //델리게이트 설정
        locationManager.delegate = self
        //거리 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //위치 사용 허용 알림
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            switch manager.authorizationStatus {
            case .notDetermined:
                // 위치 사용 허용 알림 (이미 requestWhenInUseAuthorization 호출됨)
                break
            case .restricted, .denied:
                print("위치 권한이 거부되었습니다")
            case .authorizedWhenInUse, .authorizedAlways:
                // 위치 사용을 허용하면 현재 위치정보 가져옴
                manager.requestLocation()
            @unknown default:
                fatalError("fatalError")
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("위치 업데이트")
            print("위도:\(location.coordinate.latitude)")
            print("경도:\(location.coordinate.longitude)")
            
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            
            featchWeatherData()
        }
    }
    private func featchWeatherData() {
        
        // data fetch
        weatherService.getWeather(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self.weather = weatherResponse.weather.first
                    self.main = weatherResponse.main
                    self.name = weatherResponse.name
                    self.setWeatherUI()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
      //이미지랑 레이블정보 띄우는부분
        private func setWeatherUI() {
            temperatureInCelsius = main!.temp
            iconImageView.image = UIImage(named: weather!.icon)
            todayWeatherViewLabel.text = "\(weather!.description)"
            temperatureLabel.text = "\(main!.temp)º"
            highloweViewLabel.text = "최고 \(main!.tempmax)º ~ 최저 \(main!.tempmin)º"
            styleViewLabel.text = styleRecommend()
            weatherDescriptionViewLabel.text = informationRecommend()
        }
    
}
//MARK: - 스타일추천,정보추천
extension ViewController {
    
    func styleRecommend() -> String {
            switch temperatureInCelsius {
            case 27...:
                return "민소매,반바지,원피스를 추천드려요"
            case 23..<27:
                return "반팔,얇은셔츠,면바지를 추천드려요"
            case 20..<23:
                return "얇은가디건,긴팔,청바지를 추천드려요"
            case 17..<20:
                return "가디건,얇은니트,청바지를 추천드려요"
            case 12..<17:
                return "자켓,가디건,야상을 추천드려요"
            case 10..<12:
                return "트렌치코트,간절기야상을 추천드려요"
            case 6..<10:
                return "울코트,가죽자켓을 추천드려요"
            case ...5:
                return "패딩,두꺼운코트,누빔옷을 추천드려요"
            default:
                return "No recommendation available"
                
            }
        }
    
    func informationRecommend() -> String {
            switch temperatureInCelsius {
            case 27...:
                return "실내 활동을 권장드려요 더위 조심하세요"
            case 23..<27:
                return "더운 날씨예요 수분을 충분히 섭취하세요"
            case 20..<23:
                return "나들이하기 좋은 날씨예요"
            case 17..<20:
                return "야외 활동이 잘 어울리는 날씨예요"
            case 12..<17:
                return "산책하기 좋은 날씨예요"
            case 10..<12:
                return "서늘한 날씨예요 감기조심하세요"
            case 6..<10:
                return "쌀쌀한 날씨예요 따뜻하게 입으시길 권장드려요"
            case ...5:
                return "추운날씨로 실내 활동을 권장드려요"
            default:
                return "추천드릴 정보가 없습니다"
                
            }
        }
    
    
}
