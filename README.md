### <p class="has-line-data" data-line-start="3" data-line-end="14">위치 기반으로 날씨를 알려주는 ios앱📢</p>

##  Tble of Contents<br>
1. [Description](#-description)
2. [Stacks](#%EF%B8%8F-stacks)
3. [WireFrames](#-WireFrames)
4. [Project Structure](#%EF%B8%8F-project-structure)
5. [Developer](#-developer)

<br>

## <p class="has-line-data" data-line-start="12" data-line-end="14">🌟 Description<br>
TEAM : 떡잎 6치원

Period : 24.05.13 ~ 24.05.24

위치기반 날씨를 알려주는 iOS 어플리케이션<br>


## <p class="has-line-data" data-line-start="20" data-line-end="21">💡기능</p>

원하는 알람 설정 및 삭제

날씨 섭씨 화씨 변환

나의 위치 정보를 통한 날씨 데이터 제공

원하는 위치 검색, 저장 서비스

어제 오늘 날씨 비교

기온에 따른 옷 스타일 추천

1일간의 시간대별 상세 날씨

1주일간의 일자별 상세 날씨 <br>
<br>

## <p class="has-line-data" data-line-start="31" data-line-end="33">🛠️ Stacks<br>
Environment <br>
<img src = https://camo.githubusercontent.com/d68a9ca7e7bd162a95193e369f2851d5e1548f11f6fce154642bc8291821e522/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f2d58636f64652d3134374546423f7374796c653d666c6174266c6f676f3d78636f6465266c6f676f436f6c6f723d7768697465>

<img src = https://camo.githubusercontent.com/0563e6563a564cc6842269359009f22cd8d905b0605fc31d2ec4721b474289c0/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f2d6769742d4630353033323f7374796c653d666c6174266c6f676f3d676974266c6f676f436f6c6f723d7768697465>
<img src = https://camo.githubusercontent.com/b96cf47430c7ed7cb8e9b863ec909ad51c20aa24c02ea07ef04c59fd56d97b19/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f2d6769746875622d3138313731373f7374796c653d666c6174266c6f676f3d676974687562266c6f676f436f6c6f723d7768697465><br>


Language
<br>
<img scr = "https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white">
<img src= "https://img.shields.io/badge/switf-F05138?style=for-the-badge&logo=swift&logoColor=white">
</br>


Communication
<br>
<img src="https://img.shields.io/badge/notion-000000?style=for-the-badge&logo=notion&logoColor=white">
 
<img src="https://img.shields.io/badge/slack-4A154B?style=for-the-badge&logo=slack&logoColor=white">

<img src="https://img.shields.io/badge/figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white">


<br>

## WireFrames <br>
<img width="817" alt="Screenshot 2024-05-24 at 8 25 20 PM" src="https://github.com/SCC-iOS-3rd/weather-app/assets/131982744/c690c477-faa6-468a-b0a8-3d8d3ed1cb6d">





## 🏛️ Project Structure
```
WakeUpClock 
├── Models
│   ├── Geocoder
│   ├── UserDefaults
│   ├── CoreData
│       ├── AlarmData+CoreDataClass
│       ├── AlarmData+CoreDataProperties
│       ├── LocationModel
│       └── LocationService
│   └── WeatherAPI
│       ├── Weather
│       ├── WeatherService
│       └── YesterdayWeather
├── Views
│   ├── LaunchScreen
│       ├── LaunchScreen
│       ├── SplashScreen
│       └── Animation0522
│   ├── Cell
│       ├── AlarmCell
│       ├── ModalTableViewCell
│       ├── LocationSearchResultTableViewCell
│       ├── LocationManagementViewTableViewCell
│       ├── HourlyWeatherCollectionViewCell
│       └── WeeklyWeatherCollectionViewCell
│   ├── LocationManagementView
│   ├── WeatherChangeView
│   └── LocationView
├── Controllers
│   ├── AddAlarmViewController
│   ├── AlarmViewController
│   ├── ViewController
│   ├── MainViewController
│   ├── WeatherDisplayViewController
│   ├── ModalViewController
│   ├── BaseViewController
│   ├── LocationSearchViewController
│   ├── NewLocationPreviewViewController
│   ├── LocationManagementViewContorller
│   ├── WeatherChangeViewController
│   └── LocationViewController
├── Widget
│   ├── myWidgetBundle
│   ├── myWidget
│   ├── Assets
│   └── Info
├── Assets
├── Info
└── 
```

## 👨‍👩‍👧‍👦 Developer

<img src="https://github.com/SCC-iOS-3rd/weather-app/assets/161270633/3760cd7d-35c0-4162-871f-68b6c68dce5f" width="100">

*  **김준철/팀장** ([Juncheoltree](https://github.com/Juncheoltree))
    - 알람추가 페이지 UI
    - 알람추가 기능 (datepicker)
    - 알람 관리 기능 (정렬, 편집)
    - 알람 코어데이터 모델 생성
      
<img src="https://github.com/SCC-iOS-3rd/weather-app/assets/161270633/7fa7f14c-caca-4ce5-b8b7-d7ba2bca4a55" width="100">

*  **김민희/팀원** ([Hee48](https://github.com/Hee48))
    - 메인 페이지 UI
    - 온도 표시 변경기능
    - 전일 날씨비교 차트 구현
    - 스타일 추천 더미데이터 모델 생성
      
<img src="https://github.com/SCC-iOS-3rd/weather-app/assets/161270633/0138cefd-ca3e-488a-83d6-cb9274128af7" height="100">

*  **방기남/팀원** ([Bread-kn72](https://github.com/Bread-kn72))
    - 즐겨찾기 페이지 UI
    - 현재 위치 정보 뷰 구현
    - 즐겨찾기 CoreData 모델 생성 CRUD 구현
    - 즐겨찾기 관리 기능 (Long Press, Swipe to Delete)
    - 저장된 위치 상세 보기 페이지 및 이동 로직 구현
  
<img src="https://github.com/SCC-iOS-3rd/weather-app/assets/161270633/bcaa04fa-42da-4a5c-a4ca-a33fdd8ee497" height="100">

*  **조현민/팀원** ([Chynmn](https://github.com/Chynmn))
    - 시간 / 주간 별 날씨 페이지 UI
    - 시간대별 날씨 예보 정보 차트 구현
    - 주간 날씨 정보 차트 구현
    - API 모델 생성  (API 사이트 이름)
      
<img src="https://github.com/SCC-iOS-3rd/weather-app/assets/161270633/5d9ae380-e853-49cf-bc59-b5166d002a01" height="100">

*  **조희라/팀원** ([Heather-Cho](https://github.com/Heather-Cho))
    - 위치 검색 페이지 UI
    - 위치 검색 기능 구현
    - 프리뷰 페이지 UI
    - 프리뷰 페이지 기능 구현
    - 지오코딩 모델 구현
    - API 모델 생성 (openweathermap)
    - 런치스크린 (Lottie)
    - 위젯
