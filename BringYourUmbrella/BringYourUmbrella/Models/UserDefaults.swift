//
//  UserDefaults.swift
//  BringYourUmbrella
//
//  Created by 희라 on 5/22/24.
//

import Foundation
import CoreLocation

extension UserDefaults {
    private enum Keys {
        static let latitude = "latitude"
        static let longitude = "longitude"
    }

    func setLocation(latitude: Double, longitude: Double) {
        removeObject(forKey: Keys.latitude)
        removeObject(forKey: Keys.longitude)
        set(latitude, forKey: Keys.latitude)
        set(longitude, forKey: Keys.longitude)
        print("Location saved: \(latitude), \(longitude)")
    }

    func getLocation() -> (latitude: Double, longitude: Double)? {
        let latitude = double(forKey: Keys.latitude)
        let longitude = double(forKey: Keys.longitude)

        // 유효한 값이 저장되어 있는지 확인
        if latitude != 0.0 || longitude != 0.0 {
            print("Location loaded: \(latitude), \(longitude)")
            return (latitude, longitude)
        } else {
            return nil
        }
    }

    func clearLocation() {
        removeObject(forKey: Keys.latitude)
        removeObject(forKey: Keys.longitude)
        print("Location cleared")
    }
}
