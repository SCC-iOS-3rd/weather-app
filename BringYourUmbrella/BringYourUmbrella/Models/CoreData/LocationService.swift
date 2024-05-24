//
//  LocationService.swift
//  BringYourUmbrella
//
//  Created by Kinam on 5/17/24.
//

import Foundation
import CoreData

class LocationService {
    static var shard = LocationService()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LocationModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveToContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveLocation(cityTitle: String, latitude: Double, longitude: Double) {
        if let entity = NSEntityDescription.entity(forEntityName: "Location", in: context) {
            let location = Location(entity: entity, insertInto: context)
            
            location.cityTitle = cityTitle
            location.latitude = latitude
            location.longitude = longitude
            
            saveToContext()
        }
    }
    
    func fetchLocations() -> [Location] {
        do {
            let request = Location.fetchRequest()
            let results = try context.fetch(request)
            return results
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func deleteLocations(location: [Location]) {
        let fetchResults = fetchLocations()
        let removeToLocation = fetchResults.filter({ $0.latitude == location.first?.latitude})[0]
        context.delete(removeToLocation)
        saveToContext()
    }
}
