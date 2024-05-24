//
//  NoHighlightButton.swift
//  BringYourUmbrella
//
//  Created by Hee  on 5/16/24.
//

import UIKit

//버튼 반짝거림 사라지게하기
class NoHighlightButton: UIButton {
    override var isHighlighted: Bool {
        get {
            return false
        }
        set {
           // Do nothing
        }
    }
}
