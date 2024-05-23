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

    @NSManaged public var time: Date?
    @NSManaged public var isOn: Bool

}

extension AlarmData : Identifiable {

}
