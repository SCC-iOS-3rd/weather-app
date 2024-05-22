//
//  WeatherChangeViewController.swift
//  BringYourUmbrella
//
//  Created by /Chynmn/M1 pro—̳͟͞͞♡ on 5/17/24.
//

import UIKit
import SnapKit

class WeatherChangeViewController : UIViewController {
    
    private let weatherChangeView = WeatherChangeView()
    //api
    let weatherService = WeatherService()
    var weather: Weather?
    var sys: Sys?
    var main: Main?
    var name: String?
    //위도 경도
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    
    override func loadView() {
        view = weatherChangeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    

    
}


