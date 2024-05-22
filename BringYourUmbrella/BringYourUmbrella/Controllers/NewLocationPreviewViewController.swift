//
//  NewLocationPreviewViewController.swift
//  BringYourUmbrella
//
//  Created by 희라 on 5/13/24.
//

// ⭐️ 프리뷰페이지 : 장소검색>테이블뷰셀 탭 했을 때 뜨는 미리보기 페이지 ⭐️

import UIKit
import SnapKit
import CoreData

class NewLocationPreviewViewController: BaseViewController {
    
    // MARK: - 프로퍼티
    //api
    let weatherService = WeatherService()
    //코어데이터
    let locationService = LocationService()
    
    let mainViewController = MainViewController()
    
    var temperatureInCelsius: Double = 0.0
    
    //위도와 경도
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var locationName: String = ""
    
    
    // 받아온 데이터를 저장할 프로퍼티
    var weather: Weather?
    var main: Main?
    var sys: Sys?
    var name: String?
    
    //로딩창
    weak var sv: UIView!
    
    //메인페이지 구성요소
    //1.상단 ui (프리뷰페이지라 기능 제외)
    let todayWeatherStackView = UIStackView()
    
    let umbrellaImage = UIImageView() //LOGO
    let nameLabel = UILabel() //"우산챙겨"
    let timeLabel = UILabel() //"5/13 (월) 11:44 AM"
    
    
    let locationLabel = UILabel() // 현재 위치
    
    //2.날씨정보 뷰 ui
    //views
    var iconImageView = UIImageView() //썬 이미지에서 변경
    let todayWeatherView = UIView() //첫 번째 뷰
    let highloweTemperatureView = UIView() //두 번째 뷰
    let styleView = UIView() //세 번째 뷰
    let weatherDescriptionView = UIView() //네 번째 뷰
    
    //Labels
    let todayWeatherViewLabel = UILabel() //첫 번째 뷰
    let temperatureLabel = UILabel() //첫 번째 뷰
    let highloweViewLabel = UILabel() //두 번째 뷰
    let styleViewLabel = UILabel() //세 번째 뷰
    let weatherDescriptionViewLabel = UILabel() //네 번째 뷰
    
    //3. 플로팅 버튼
    let addNewLocationButton = UIButton()
    //모달창부분
    let alphaView = UIView()
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        sv = UIViewController.displaySpinner(onView: self.view)
        //self.locationName = tranceSubAdministrativeArea(latitude: self.latitude, longitude: self.longitude)
        
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
    
    
    // MARK: - setWeatherUI
    
    private func setWeatherUI() {
        temperatureInCelsius = main!.temp
        guard let weatherIcon = weather?.icon else { return }
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(weatherIcon)@2x.png") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to fetch image data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.iconImageView.image = image
                }
            }
        }
        task.resume()
        
        DispatchQueue.main.async {
            self.todayWeatherViewLabel.text = "\(self.weather!.description)"
            self.temperatureLabel.text = "\(Int(self.main!.temp))º"
            self.highloweViewLabel.text = "최고 \(Int(self.main!.tempmax))º ~ 최저 \(Int(self.main!.tempmin))º"
        }
        self.styleViewLabel.text = mainViewController.styleRecommend()
        self.weatherDescriptionViewLabel.text = mainViewController.informationRecommend()
        self.sv.removeFromSuperview()
    }//func setWeatherUI()
    
    
    //MARK: - 레이아웃, addSubview
    
    override func setupConstraints() {
        [umbrellaImage, nameLabel, timeLabel, locationLabel, todayWeatherView, highloweTemperatureView, styleView, weatherDescriptionView, addNewLocationButton].forEach {
            view.addSubview($0)
        }
        [todayWeatherViewLabel, temperatureLabel].forEach {
            todayWeatherStackView.addArrangedSubview($0)
        }
        [iconImageView, todayWeatherStackView].forEach { // 썬 이미지에서 변경
            todayWeatherView.addSubview($0)
        }
        highloweTemperatureView.addSubview(highloweViewLabel)
        styleView.addSubview(styleViewLabel)
        weatherDescriptionView.addSubview(weatherDescriptionViewLabel)
        
        umbrellaImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(30)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(umbrellaImage.snp.trailing).offset(10)
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
        todayWeatherStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 10))
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
        iconImageView.snp.makeConstraints { // 썬 이미지에서 변경
            $0.leading.equalToSuperview().offset(10)
            $0.verticalEdges.equalToSuperview().inset(15)
            $0.trailing.equalTo(todayWeatherStackView.snp.leading)
            $0.centerY.equalToSuperview()
        }
        addNewLocationButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
            make.height.equalTo(47)
        }
    }
    
    //MARK: - UI 속성
    
    override func configureUI() {
        view.backgroundColor = UIColor(red: 0.4039, green: 0.7765, blue: 0.8902, alpha: 1)
        umbrellaImage.image = UIImage(systemName: "umbrella")
        umbrellaImage.tintColor = .white
        
        
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
        
        // 날씨 정보 label
        //1. 오늘의 날씨
        iconImageView.contentMode = .scaleAspectFit
        todayWeatherViewLabel.text = "지역을 찾고 있어요"
        //2. 최고/최저 기온
        highloweViewLabel.text = "최고 ~ 최저기온"
        //3. 미정
        styleViewLabel.text = "날씨에 따른 스타일을 추천해 드릴게요"
        //4. 추천문구
        weatherDescriptionViewLabel.text = "날씨에 따른 정보를 제공해드릴게요"
        //프리뷰 페이지 > 액션 제외
        
        addNewLocationButton.backgroundColor = .black
        addNewLocationButton.layer.cornerRadius = 10
        addNewLocationButton.setTitle("추가", for: .normal)
        addNewLocationButton.setTitleColor(.white, for: .normal)
        addNewLocationButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        alphaView.backgroundColor = .black
        alphaView.alpha = 0
        
        addNewLocationButton.addTarget(self, action: #selector(addNewLocationButtonAction), for: .touchUpInside)
    }
    
    //뷰 스타일 양식
    func styleView(_ view: UIView, backgroundColor: UIColor = .white, cornerRadius: CGFloat = 10) {
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
    }
    
    //추가 버튼 액션 함수
    @objc func addNewLocationButtonAction() {
        locationService.saveLocation(cityTitle: locationName, latitude: latitude, longitude: longitude)
//        let newVC = UIViewController()
//        let mainView = MainView()
//        newVC.view = mainView
//        
//        func setNewVCWeatherUI() {
//            temperatureInCelsius = main!.temp
//            guard let weatherIcon = weather?.icon else { return }
//            guard let url = URL(string: "https://openweathermap.org/img/wn/\(weatherIcon)@2x.png") else { return }
//            
//            let task = URLSession.shared.dataTask(with: url) { data, response, error in
//                guard let data = data, error == nil else {
//                    print("Failed to fetch image data: \(error?.localizedDescription ?? "Unknown error")")
//                    return
//                }
//                
//                DispatchQueue.main.async {
//                    if let image = UIImage(data: data) {
//                        mainView.todayweatherImageView.image = image
//                    }
//                }
//            }
//            task.resume()
//            
//            DispatchQueue.main.async {
//                self.temperatureInCelsius = self.main!.temp
//                mainView.iconImageView.image = UIImage(named: self.weather!.icon)
//                mainView.todayWeatherViewLabel.text = "\(self.weather!.description)"
//                mainView.temperatureLabel.text = "\(self.main!.temp)º"
//                mainView.todayTemperatureLabel.text = "\(self.main!.temp)º"
//                mainView.highloweViewLabel.text = "최고 \(self.main!.tempmax)º ~ 최저 \(self.main!.tempmin)º"
//                mainView.todayWeatherLabel.text = "\(self.weather!.description)"
//                mainView.todayHighLoweLabel.text = "\(self.main!.tempmax)º \(self.main!.tempmin)º"
//                
//            }
//            mainView.weatherDescriptionViewLabel.text = informationRecommend()
//            mainView.styleViewLabel.text = styleRecommend()
//            
//            func datefunc() -> String {
//                let date = Date()
//                let dateFormatterKR = DateFormatter()
//                dateFormatterKR.dateFormat = "M/dd (E) HH:mm"
//                dateFormatterKR.locale = Locale(identifier: "ko_KR")
//                dateFormatterKR.timeZone = TimeZone(abbreviation: "KST")
//                let datePart = dateFormatterKR.string(from: date)
//                
//                let dateFormatterDefault = DateFormatter()
//                dateFormatterDefault.dateFormat = "a"
//                dateFormatterDefault.timeZone = TimeZone(abbreviation: "KST")
//                let dateDefault = dateFormatterDefault.string(from: date)
//                
//                let todayDate = "\(datePart) \(dateDefault)"
//                return todayDate
//            }
//            
//            func styleRecommend() -> String {
//                    switch temperatureInCelsius {
//                    case 27...:
//                        return "민소매,반바지,원피스를 추천드려요"
//                    case 23..<27:
//                        return "반팔,얇은셔츠,면바지를 추천드려요"
//                    case 20..<23:
//                        return "얇은가디건,긴팔,청바지를 추천드려요"
//                    case 17..<20:
//                        return "가디건,얇은니트,청바지를 추천드려요"
//                    case 12..<17:
//                        return "자켓,가디건,야상을 추천드려요"
//                    case 10..<12:
//                        return "트렌치코트,간절기야상을 추천드려요"
//                    case 6..<10:
//                        return "울코트,가죽자켓을 추천드려요"
//                    case ...5:
//                        return "패딩,두꺼운코트,누빔옷을 추천드려요"
//                    default:
//                        return "No recommendation available"
//                        
//                    }
//                }
//            
//            func informationRecommend() -> String {
//                    switch temperatureInCelsius {
//                    case 27...:
//                        return "실내 활동을 권장드려요 더위 조심하세요"
//                    case 23..<27:
//                        return "더운 날씨예요 수분을 충분히 섭취하세요"
//                    case 20..<23:
//                        return "나들이하기 좋은 날씨예요"
//                    case 17..<20:
//                        return "야외 활동이 잘 어울리는 날씨예요"
//                    case 12..<17:
//                        return "산책하기 좋은 날씨예요"
//                    case 10..<12:
//                        return "서늘한 날씨예요 감기조심하세요"
//                    case 6..<10:
//                        return "쌀쌀한 날씨예요 따뜻하게 입으시길 권장드려요"
//                    case ...5:
//                        return "추운날씨로 실내 활동을 권장드려요"
//                    default:
//                        return "추천드릴 정보가 없습니다"
//                        
//                    }
//                }
//        }
//        setNewVCWeatherUI()
//        mainViewController.dataViewControllers.append(newVC)
//        mainViewController.dataViewControllers = mainViewController.dataViewControllers
//        print(mainViewController.dataViewControllers)
        
        let mainPageVC = ViewController()
        //self.navigationController?.pushViewController(mainPageVC, animated: true)
        let navigationController = UINavigationController(rootViewController: mainPageVC)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
//시간표시 함수
extension NewLocationPreviewViewController {
    
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


