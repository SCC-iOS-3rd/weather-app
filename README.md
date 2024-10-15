# 🌤️ Bring Your Umbrella 

```

 사용자의 현재 위치 기반으로 날씨 예보를 알려주는 ios앱 📱

 기상날씨 정보를 제공하는 앱 프로젝트인 BringYourUmbrella 입니다.

 사용자에게 기존의 날씨앱과 UX관점에서 차별화된 경험을 할 수 있도록 구현하였습니다.

```
---

## ⛈️ Table of Contents<br>
1. [Description](#-description)
2. [Stacks](#%EF%B8%8F-stacks)
3. [WireFrames](#-wireframes)
4. [Main Feature](#-main-feature)
5. [Project Structure](#%EF%B8%8F-project-structure)
6. [Developer](#-developer)

<br>

## 🌟 Description
TEAM : 떡잎 6치원

Period : 24.05.13 ~ 24.05.23

사용자의 현재 위치기반 날씨를 알려주는 iOS 어플리케이션<br>

</br>

💡**기능**

- 원하는 알람 설정 및 삭제
- 날씨 섭씨 화씨 변환
- 나의 위치 정보를 통한 날씨 데이터 제공
- 원하는 위치 검색, 저장 서비스
- 어제 오늘 날씨 비교
- 기온에 따른 옷 스타일 추천
- 1일간의 시간대별 상세 날씨
- 1주일간의 일자별 상세 날씨 <br>
<br>

## 🛠️ Stacks

**Language**

<img scr = "https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white"> <img src= "https://img.shields.io/badge/switf-F05138?style=for-the-badge&logo=swift&logoColor=white">
</br>

**Communication**

<img src="https://img.shields.io/badge/notion-000000?style=for-the-badge&logo=notion&logoColor=white"> <img src="https://img.shields.io/badge/slack-4A154B?style=for-the-badge&logo=slack&logoColor=white"> <img src="https://img.shields.io/badge/figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white">

</br></br>

## 🎨 WireFrames
<img width="817" alt="Screenshot 2024-05-24 at 8 25 20 PM" src="https://github.com/SCC-iOS-3rd/weather-app/assets/131982744/c690c477-faa6-468a-b0a8-3d8d3ed1cb6d">
</br>
<br>
</br>

## 📱 Main Feature
### 1) Current Weather Page 🌦️
<table align="leading">
  <tr>
    <td align="center">launchScreen</td>
    <td align="center">현재 위치 날씨</td>
    <td align="center">섭씨 <-> 화씨 변경</td>
  </tr>
  <tr>
   <td><img width="250" alt="image" src="https://github.com/SCC-iOS-3rd/weather-app/assets/100783766/c2628470-b087-47fa-b11e-e043f4254ff3"></td>
   <td><img width="250" alt="image" src="https://github.com/SCC-iOS-3rd/weather-app/assets/100783766/6dc0dd40-6170-434c-9ead-07e9925b9953"></td>
   <td><img width="235" alt="image" src="https://github.com/SCC-iOS-3rd/weather-app/assets/100783766/7cfe8acb-d01c-4584-aa37-498657d18ca5"></td>
  </tr>
</table>
<br>

- **LottieFiles**Animation을 활용한 LaunchScreen
- Mapkit기반 사용자 현재 위치의 현재 날씨와 기온 및 추천 옷차림 확인 가능!
- 섭씨와 화씨로 온도 표현 변경

</br>

### 2) AlarmList Page 🌧️
<table align="leading">
  <tr>
    <td align="center">알람 설정</td>
    <td align="center">알람 리스트</td>
  </tr>
  <tr>
   <td><img width="250" alt="image" src="https://github.com/SCC-iOS-3rd/weather-app/assets/100783766/428fce1e-50e3-4848-a69a-9b9feb2430c8"></td>
   <td><img width="235" alt="image" src="https://github.com/SCC-iOS-3rd/weather-app/assets/100783766/5079beb6-fae0-4b28-b802-af60bcd31c37"></td>
  </tr>
</table>
<br>

- UIPickerView로 원하는 시간에 알람을 설정
- 설정한 알람 목록 확인
- Toggle을 통한 알람 on/off
- 설정한 시간에 Push 알림과 사운드 재생

</br>

### 3) Weather Forecast Page 🌥️
<table align="leading">
  <tr>
    <td align="center">어제와 오늘 날씨 바교</td>
    <td align="center">시간대별, 주간 날씨예보</td>
  </tr>
  <tr>
   <td><img width="250" alt="image" src="https://github.com/SCC-iOS-3rd/weather-app/assets/100783766/9a11fd94-909c-44ed-a536-ed2547e5c1dc"></td>
   <td><img width="240" alt="image" src="https://github.com/SCC-iOS-3rd/weather-app/assets/100783766/3c44e9d7-81b0-4963-8fa4-3f2174de7956"></td>
  </tr>
</table>
<br>

- 사용자가 체감온도를 예상할 수 있도록 어제와 오늘 날씨를 비교
- 3시간 단위의 시간대별 날씨예보 차트
- 5일간의 주간 날씨예보 차트

</br>

### 4) Location Search Page ⛅️
<table align="leading">
  <tr>
    <td align="center">현위치 및 즐겨찾기 날씨 목록</td>
    <td align="center">장소 검색</td>
    <td align="center">검색 결과</td>
    <td align="center">즐겨찾기 목록 편집모드</td>
  </tr>
  <tr>
   <td><img width="250" alt="image" src="https://github.com/SCC-iOS-3rd/weather-app/assets/100783766/345807ca-4d21-439b-9e73-75bd59c940c9"></td>
   <td><img width="250" alt="image" src="https://github.com/SCC-iOS-3rd/weather-app/assets/100783766/30bebb04-766b-4240-8769-6b952bc29017"></td>
   <td><img width="250" alt="image" src="https://github.com/SCC-iOS-3rd/weather-app/assets/100783766/00e41a20-7d23-40d2-95af-e0d31ab5dee8"></td>
   <td><img width="250" alt="image" src="https://github.com/SCC-iOS-3rd/weather-app/assets/100783766/19c8a9f6-ae6d-4526-aacc-c32779f618a7"></td>
  </tr>
</table>
<br>

- Mapkit 라이브러리를 활용해 위도, 경도 좌표를 추출해 날씨 데이터 CRUD
- CoreData의 각 Entity와 Attribute에 데이터 저장
- 최근 검색한 장소의 날씨 정보를 즐겨찾기에 추가해 현재 날씨 정보 확인 가능!
- 편집모드를 실행해 즐겨찾기 목록 데이터 변경


</br>

### 5) Weather Widget 🌨️
<table align="leading">
  <tr>
    <td align="center">위젯 생성</td>
    <td align="center">홈화면에 생성된 위젯</td>
  </tr>
  <tr>
   <td><img width="250" alt="image" src="https://github.com/SCC-iOS-3rd/weather-app/assets/100783766/d599134a-af6c-40da-b838-07663a18c204"></td>
   <td><img width="250" alt="image" src="https://github.com/SCC-iOS-3rd/weather-app/assets/100783766/8b013dfb-1bc3-442e-a853-915e832e51fe"></td>
  </tr>
</table>
<br>

- 아이폰 홈화면에 생성된 위젯을 통해 간단히 현재 날씨 정보 확인 가능!
- 2x2, 2x4 형태의 위젯 생성

<br>


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
    - API 모델 생성 (openweather-map, weather-api)
      
<img src="https://github.com/SCC-iOS-3rd/weather-app/assets/161270633/5d9ae380-e853-49cf-bc59-b5166d002a01" height="100">

*  **조희라/팀원** ([Heather-Cho](https://github.com/Heather-Cho))
    - 위치 검색 페이지 UI
    - 위치 검색 기능 구현
    - 프리뷰 페이지 UI
    - 프리뷰 페이지 기능 구현
    - 지오코딩 모델 구현
    - API 모델 생성 (openweather-map)
    - 런치스크린 (Lottie)
    - 위젯
