//
//  Geocoder.swift
//  BringYourUmbrella
//
//  Created by 희라 on 5/17/24.
//

// ⭐️ 지오코딩 : 위도/경도 값으로 지역명을 텍스트로 추출 ⭐️
// 4가지 버젼이 있어서 골라서 사용하시면 됩니다.


import CoreLocation

// 주, 주(도), 도 단위로 표시
func tranceAdministrativeArea(latitude: Double, longitude: Double) -> String {
    var locationName = ""
    
    let location = CLLocation(latitude: latitude, longitude: longitude)
    let geocoder = CLGeocoder()
    
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
    return locationName
}


// 군, 구, 군 단위로 표시
func tranceSubAdministrativeArea(latitude: Double, longitude: Double) -> String {
    var locationName = ""
    
    let location = CLLocation(latitude: latitude, longitude: longitude)
    let geocoder = CLGeocoder()
    
    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
        guard let placemark = placemarks?.first else {
            print("Failed to reverse geocode location.")
            return
        }
        
        if let subAdministrativeArea = placemark.subAdministrativeArea {
            locationName = subAdministrativeArea
        } else {
            print("지역 이름을 찾을 수 없습니다.")
        }
    }
    return locationName
}


// 시, 시(군), 구
func tranceLocality(latitude: Double, longitude: Double) -> String {
    var locationName = ""

    let location = CLLocation(latitude: latitude, longitude: longitude)
    let geocoder = CLGeocoder()
    
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
    return locationName
}


// 지구, 동 등
func tranceSubLocality(latitude: Double, longitude: Double) -> String {
    var locationName = ""

    let location = CLLocation(latitude: latitude, longitude: longitude)
    let geocoder = CLGeocoder()
    
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
    return locationName
}



// 해당되는게 있으면 그걸로 반환. 우선순위 보유
func tranceLocationName(latitude: Double, longitude: Double) -> String {
    var locationName = ""
    
    let location = CLLocation(latitude: latitude, longitude: longitude)
    let geocoder = CLGeocoder()
    
    // 동기적으로 reverseGeocodeLocation을 실행하기 위해 Dispatch를 사용합니다.
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard let placemark = placemarks?.first else {
                print("Failed to reverse geocode location.")
                return
            }
            
            // administrativeArea 우선순위
            if let administrativeArea = placemark.administrativeArea {
                locationName = administrativeArea
            }
            // subAdministrativeArea 우선순위
            else if let subAdministrativeArea = placemark.subAdministrativeArea {
                locationName = subAdministrativeArea
            }
            // locality 우선순위
            else if let locality = placemark.locality {
                locationName = locality
            }
            // subLocality 우선순위
            else if let subLocality = placemark.subLocality {
                locationName = subLocality
            }
            // 어떤 지역명도 발견되지 않을 경우
            else {
                print("지역 이름을 찾을 수 없습니다.")
            }
        }
    
    return locationName
}
