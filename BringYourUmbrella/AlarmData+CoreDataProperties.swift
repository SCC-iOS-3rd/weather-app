//
//  AlarmData+CoreDataProperties.swift
//  BringYourUmbrella
//
//  Created by 김준철 on 5/23/24.
//
//

import Foundation
import CoreData


extension AlarmData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlarmData> {
        return NSFetchRequest<AlarmData>(entityName: "AlarmData")
    }

    @NSManaged public var isOn: Bool
    @NSManaged public var time: Date?
    
    
    func timeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        guard let time = self.time else{
            return "No Time Set"
        }
        return formatter.string(from: time)//옵셔널 언래핑 찾아보기
    }

}

extension AlarmData : Identifiable {

}
