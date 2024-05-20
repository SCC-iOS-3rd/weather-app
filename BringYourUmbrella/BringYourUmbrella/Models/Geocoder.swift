//
//  Geocoder.swift
//  BringYourUmbrella
//
//  Created by 희라 on 5/17/24.
//

// ⭐️ [지오코딩] : 위도/경도 값으로 지역명을 텍스트로 추출 ⭐️
// 4가지 버젼이 있어서 골라서 사용하시면 됩니다.


import CoreLocation

// 주, 주(도), 도 단위로 표시
func tranceAdministrativeArea(latitude: Double, longitude: Double, completion: @escaping (String) -> Void) {
    var locationName = ""
    
    let location = CLLocation(latitude: latitude, longitude: longitude)
    let geocoder = CLGeocoder()
    
    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
        guard let placemark = placemarks?.first else {
            print("Failed to reverse geocode location.")
            completion(locationName)
            return
        }
        
        if let administrativeArea = placemark.administrativeArea {
            completion(administrativeArea)
        } else {
            print("지역 이름을 찾을 수 없습니다.")
            completion("")
        }
    }
}

// 시, 시(군), 구
func tranceLocality(latitude: Double, longitude: Double, completion: @escaping (String) -> Void) {
    var locationName = ""

    let location = CLLocation(latitude: latitude, longitude: longitude)
    let geocoder = CLGeocoder()
    
    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
        guard let placemark = placemarks?.first else {
            print("Failed to reverse geocode location.")
            completion(locationName)
            return
        }
        
        if let locality = placemark.locality {
            completion(locality)
        } else {
            print("지역 이름을 찾을 수 없습니다.")
            completion("")
        }
    }
}

// 지구, 동 등
func tranceSubLocality(latitude: Double, longitude: Double, completion: @escaping (String) -> Void) {
    var locationName = ""

    let location = CLLocation(latitude: latitude, longitude: longitude)
    let geocoder = CLGeocoder()
    
    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
        guard let placemark = placemarks?.first else {
            print("Failed to reverse geocode location.")
            completion(locationName)
            return
        }
        
        if let subLocality = placemark.subLocality {
            completion(subLocality)
        } else {
            print("지역 이름을 찾을 수 없습니다.")
            completion("")
        }
    }
}

// 시 + 동
func tranceLocationName(latitude: Double, longitude: Double, completion: @escaping (String) -> Void) {
    var locationName = ""
    
    let location = CLLocation(latitude: latitude, longitude: longitude)
    let geocoder = CLGeocoder()
    
    geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
        guard let placemark = placemarks?.first else {
            print("Failed to reverse geocode location.")
            completion(locationName)
            return
        }
        
        //시 이름
        if let administrativeArea = placemark.administrativeArea {
            locationName = administrativeArea
        }
        //동 이름
        if let subLocality = placemark.subLocality {
            if !locationName.isEmpty {
                locationName += " "
            }
            locationName += subLocality
        }
        
        if locationName.isEmpty {
            print("지역 이름을 찾을 수 없습니다.")
        }
        
        completion(locationName)
    }
}


