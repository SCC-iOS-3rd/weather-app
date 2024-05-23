
import UIKit
import SnapKit
import Lottie

class ViewController: BaseViewController {
    
    //위도와 경도
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    //섭씨 화씨 변경 임의값 넣어둔것
    var temperatureInCelsius: Double = 0.0
    var maxTemperatureInCelsius: Double = 0.0
    var minTemperatureInCelsius: Double = 0.0
    let umbrellaImage = UIImageView()
    
    //섭씨화씨,알람,플러스버튼
    let temperatureButton = UIButton()
    let alarmButton = NoHighlightButton(type: .system)
    let plusButton = NoHighlightButton(type: .system)
    //버튼들을 스텍뷰로묶음
    let buttonStackView = UIStackView()
    //우산챙겨 Label
    let nameLabel = UILabel()
    let timeLabel = UILabel()
    //현재위치 Label
    let locationLabel = UILabel()
    //모달창부분
    let alphaView = UIView()
    // Refresh control
    let refreshControl = UIRefreshControl()
    // ScrollView
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        setupRefreshControl()
        
        // 런치스크린
        setupAnimationView()
        
        vc1.locationDelegate = self
        
        // 처음 보여질 페이지
        if let firstVC = dataViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true)
        }
        
        // 저장된 위도 경도값이 있는지 확인하는 용도
        if let location = UserDefaults.standard.getLocation() {
            print("Saved latitude: \(location.latitude)")
            print("Saved longitude: \(location.longitude)")
        } else {
            print("No saved location found")
        }
        
        
    }
    
    
    // MARK: - 리프레시 컨트롤러
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
    // Refresh control handle
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        vc1.setLocationManager() // 현재위치정보 업데이트
        refreshControl.endRefreshing()
    }
    
    // MARK: - 런치스크린
    func setupAnimationView() {
            view.addSubview(animationView)
            
            animationView.frame = view.bounds
            animationView.center = view.center
            animationView.contentMode = .scaleAspectFill
            animationView.loopMode = .playOnce
            
            animationView.play { (finished) in
                if finished {
                    UIView.animate(withDuration: 0.3, animations: {
                       animationView.alpha = 0
                    }, completion: { _ in
                        animationView.isHidden = true
                        animationView.removeFromSuperview()
                    })
                } else {
                    print("Animation interrupted")
                }
            }
        }
    
    //상단 네비게이션뷰
    let navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.4039, green: 0.7765, blue: 0.8902, alpha: 1)
        return view
    }()
    
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return vc
    }()
    
    //첫번째 뜨는 뷰(메인)
    lazy var vc1: MainViewController = {
        let vc = MainViewController()
        vc.view.backgroundColor = UIColor(red: 0.4039, green: 0.7765, blue: 0.8902, alpha: 1)
        return vc
    }()
    
    //왼쪽 1번째 뷰(날씨표시)
    lazy var vc2: WeatherDisplayViewController = {
        let vc = WeatherDisplayViewController()
        vc.latitude = latitude
        vc.longitude = longitude
        vc.view.backgroundColor = UIColor(red: 0.4039, green: 0.7765, blue: 0.8902, alpha: 1)
        return vc
    }()
    
    //왼쪽 2번째 뷰(날씨차트)
    lazy var vc3: WeatherChangeViewController = {
        let vc = WeatherChangeViewController()
        vc.latitude = latitude
        vc.longitude = longitude
//        vc.view.backgroundColor = UIColor(red: 0.4039, green: 0.7765, blue: 0.8902, alpha: 1)
        return vc
    }()

    lazy var dataViewControllers: [UIViewController] = {
        return [vc1, vc2, vc3]
    }()
    
    //MARK: - 오토레이아웃
    override func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(navigationView)
        contentView.addSubview(pageViewController.view)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(scrollView)
        }
        
        [umbrellaImage, nameLabel, buttonStackView, timeLabel, locationLabel].forEach {
            navigationView.addSubview($0)
        }
        [temperatureButton, alarmButton, plusButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        //우산이미지
        umbrellaImage.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.top)
            $0.leading.equalToSuperview().offset(20)
            $0.height.width.equalTo(30)
        }
        //우산챙겨
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.top)
            $0.leading.equalTo(umbrellaImage.snp.trailing).offset(10)
        }
        //단위변경,알람,위치추가 버튼 스택뷰
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.top)
            $0.trailing.equalToSuperview().offset(-30)
        }
        //현재시각Label
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(umbrellaImage.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(20)
        }
        //현재위치Label
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(20)
        }

        //상단 네비게이션 뷰
        navigationView.snp.makeConstraints {
            $0.width.top.equalToSuperview()
            $0.height.equalTo(120)
        }
        //페이지뷰
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        pageViewController.didMove(toParent: self)
    }
    //MARK: - UI속성,버튼정보
    override func configureUI() {
        view.backgroundColor = UIColor(red: 0.4039, green: 0.7765, blue: 0.8902, alpha: 1)
        self.navigationController?.isNavigationBarHidden = true
        umbrellaImage.image = UIImage(systemName: "umbrella")
        umbrellaImage.tintColor = .white
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fill
        nameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        nameLabel.textColor = .white
        timeLabel.text = datefunc()
        timeLabel.textColor = .white
        locationLabel.text = "현재 위치"
        nameLabel.text = "우산 챙겨"
        locationLabel.textColor = .white
        locationLabel.font = UIFont.boldSystemFont(ofSize: 20)
        temperatureButton.setTitle("ºC", for: .normal)
        temperatureButton.setTitleColor(.white, for: .normal)
        temperatureButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        alarmButton.setImage(UIImage(systemName: "bell.badge"), for: .normal)
        alarmButton.tintColor = .white
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.tintColor = .white
        alphaView.backgroundColor = .black
        alphaView.alpha = 0
        //화면이동+섭씨화씨 버튼들
        temperatureButton.addTarget(self, action: #selector(temperatureChange), for: .touchUpInside)
        alarmButton.addTarget(self, action: #selector(alarmButtonMove), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonMove), for: .touchUpInside)
        //페이지뷰컨트롤러 델리게이트,데이터소스
        pageViewController.delegate = self
        pageViewController.dataSource = self
    }
    
    func addViewController(_ viewController: UIViewController) {
        dataViewControllers.append(viewController)
        pageViewController.dataSource = self
        pageViewController.setViewControllers([viewController], direction: .reverse, animated: true)
    }
}
//MARK: - 단위변경 모달창
extension ViewController: BullletinDelegate {
    
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
        
        vc1.updateTemperatureLabel(unit: unit)
        vc2.updateTemperatureLabel(unit: unit)
    }
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
//MARK: - 알람,플러스 화면이동
extension ViewController: LocationDelegate {
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
    //현재위치 좌표 받아오기+vc2페이지 넘겨주기
    func didUpdateLocation(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        vc2.latitude = latitude
        vc2.longitude = longitude
        vc2.fetchyesterdayweather()
        vc3.latitude = latitude
        vc3.longitude = longitude
        updateLocationName()
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
//MARK: - 페이지뷰컨트롤러
extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return dataViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == dataViewControllers.count {
            return nil
        }
        return dataViewControllers[nextIndex]
    }
}
//MARK: - 현재위치
extension ViewController {
    
    func updateLocationName() {
        //현재위치명, 아이콘, 온도로 업데이트
        tranceLocationName(latitude: latitude, longitude: longitude) { locationName in
            DispatchQueue.main.async {
                self.locationLabel.text = "\(locationName)"
            }
        }
    }
}


