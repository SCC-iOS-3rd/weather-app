//
//  Geocoder.swift
//  BringYourUmbrella
//
//  Created by 희라 on 5/17/24.
//

// ⭐️ 지오코딩 : 위도/경도 값으로 지역명을 텍스트로 추출 ⭐️


import CoreLocation

// 주, 주(도), 도 단위로 표시
func tranceAdministrativeArea(latitude: Double, longitude: Double) {
    
    //CLLocation 객체
    let location = CLLocation(latitude: latitude, longitude: longitude)
    //CLGeocoder()
    let geocoder = CLGeocoder()
    
    // 지오코딩 수행
    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
        guard let placemark = placemarks?.first else {
            print("Failed to reverse geocode location.")
            return
        }
        
        if let administrativeArea = placemark.administrativeArea {
            print("지역이름: \(administrativeArea)")
        } else {
            print("지역 이름을 찾을 수 없습니다.")
        }
    }
}

// 군, 구, 군 단위로 표시
func tranceSubAdministrativeArea(latitude: Double, longitude: Double) {
    
    //CLLocation 객체
    let location = CLLocation(latitude: latitude, longitude: longitude)
    //CLGeocoder()
    let geocoder = CLGeocoder()
    
    // 지오코딩 수행
    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
        guard let placemark = placemarks?.first else {
            print("Failed to reverse geocode location.")
            return
        }
        
        if let subAdministrativeArea = placemark.subAdministrativeArea {
            print("지역이름: \(subAdministrativeArea)")
        } else {
            print("지역 이름을 찾을 수 없습니다.")
        }
    }
}

// 시, 시(군), 구
func tranceLocality(latitude: Double, longitude: Double) {
    
    //CLLocation 객체
    let location = CLLocation(latitude: latitude, longitude: longitude)
    //CLGeocoder()
    let geocoder = CLGeocoder()
    
    // 지오코딩 수행
    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
        guard let placemark = placemarks?.first else {
            print("Failed to reverse geocode location.")
            return
        }
        
        if let locality = placemark.locality {
            print("지역이름: \(locality)")
        } else {
            print("지역 이름을 찾을 수 없습니다.")
        }
    }
}


// 지구, 동 등
func tranceSubLocality(latitude: Double, longitude: Double) {
    
    //CLLocation 객체
    let location = CLLocation(latitude: latitude, longitude: longitude)
    //CLGeocoder()
    let geocoder = CLGeocoder()
    
    // 지오코딩 수행
    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
        guard let placemark = placemarks?.first else {
            print("Failed to reverse geocode location.")
            return
        }
        
        if let subLocality = placemark.subLocality {
            print("지역이름: \(subLocality)")
        } else {
            print("지역 이름을 찾을 수 없습니다.")
        }
    }
}
