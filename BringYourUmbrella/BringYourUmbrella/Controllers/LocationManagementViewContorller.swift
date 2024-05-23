//
//  LocationManagementViewContorller.swift
//  BringYourUmbrella
//
//  Created by Kinam on 5/13/24.
//

import UIKit
import CoreData

class LocationManagementViewContorller: UIViewController {
    // MARK: - properties
    let locationManagerView = LocationManagementView()
    let weatherService = WeatherService()
    
    var locationList: [Location] = []
    
    
    //위도와 경도
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var mylocation: String = ""
    
    // 받아온 데이터를 저장할 프로퍼티
    var weather: Weather?
    var main: Main?
    var sys: Sys?
    var name: String?
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LocationModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // datafetch
        weatherService.getWeather(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self.weather = weatherResponse.weather.first
                    self.main = weatherResponse.main
                    self.name = weatherResponse.name
                    self.updateCurrentLocation()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        setAddTarget()
        setTableView()
        setupLongGestureRecognizerOnTableView()
        fetchLocations()
        setRefreshControl()
    }
    
    override func loadView() {
        view = locationManagerView
    }
    
    private func updateCurrentLocation() {
        //현재위치명, 아이콘, 온도로 업데이트
        tranceLocationName(latitude: latitude, longitude: longitude) { locationName in
            DispatchQueue.main.async {
                self.locationManagerView.currentLocation.text = "\(locationName)"
                if let image = UIImage(named: self.weather!.icon) {
                    self.locationManagerView.currentWeatherImageView.image = image
                }
                self.locationManagerView.currentTemperature.text = "\(self.main?.temp ?? 0)º"
            }
        }
}

private func setAddTarget() {
    locationManagerView.bottomSearchButton.addTarget(self, action: #selector(tappedSearchBtn), for: .touchUpInside)
    locationManagerView.currentLocationButton.addTarget(self, action: #selector(tappedCurrentLocation), for: .touchUpInside)
    locationManagerView.favoritesEditButton.addTarget(self, action: #selector(tappedEditButton), for: .touchUpInside)
    locationManagerView.backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
}

func fetchLocations() {
    let context = persistentContainer.viewContext
    // 코어데이터 생성 후 Entity의 이름으로 변경해줄것
    let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()
  
    do {
        locationList = try context.fetch(fetchRequest)
    } catch {
        print("Failed to fetch saved Locations: \(error.localizedDescription)")
    }
}

private func setRefreshControl() {
    locationManagerView.favoritesTableView.refreshControl = UIRefreshControl()
    locationManagerView.favoritesTableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
}

func setTableView() {
    locationManagerView.favoritesTableView.dataSource = self
    locationManagerView.favoritesTableView.delegate = self
    locationManagerView.favoritesTableView.register(LocationManagementViewTableViewCell.self, forCellReuseIdentifier: LocationManagementViewTableViewCell.identifier)
}

@objc private func tappedSearchBtn() {
    let nextVc = LocationSearchViewController()
    nextVc.modalPresentationStyle = .pageSheet
    present(nextVc, animated: true)
}

@objc private func tappedCurrentLocation() {
    navigationController?.popViewController(animated: true)
    print("현재 위치")
}

@objc private func tappedEditButton() {
    if locationManagerView.favoritesTableView.isEditing {
        locationManagerView.favoritesEditButton.setTitle("편집", for: .normal)
        locationManagerView.favoritesTableView.setEditing(false, animated: true)
    } else {
        locationManagerView.favoritesEditButton.setTitle("완료", for: .normal)
        locationManagerView.favoritesTableView.setEditing(true, animated: true)
        locationManagerView.favoritesTableView.dragInteractionEnabled = true
        locationManagerView.favoritesTableView.dragDelegate = self
        locationManagerView.favoritesTableView.dropDelegate = self
    }
}

@objc private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
    _ = gestureRecognizer.location(in: locationManagerView.favoritesTableView)
    
    if gestureRecognizer.state == .began {
        tappedEditButton()
    } else if gestureRecognizer.state == .ended {
        // 롱 프레스 터치가 끝날 떄
    } else {
        return
    }
}

@objc private func pullToRefresh() {
    locationManagerView.favoritesTableView.reloadData()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
        self.locationManagerView.favoritesTableView.refreshControl?.endRefreshing()
    }
}

@objc private func tappedBackButton() {
    navigationController?.popToRootViewController(animated: true)
}
}

// MARK: - extensions
extension LocationManagementViewContorller: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard locationManagerView.favoritesTableView.cellForRow(at: indexPath) is LocationManagementViewTableViewCell else { return }
        let selectedLocation = locationList[indexPath.row]
        let movedVC = LocationViewController()
        movedVC.locationName = selectedLocation.cityTitle ?? "현재 위치"
        movedVC.latitude = selectedLocation.latitude
        movedVC.longitude = selectedLocation.longitude
        
        navigationController?.pushViewController(movedVC, animated: true)
    }
}

extension LocationManagementViewContorller: UIGestureRecognizerDelegate {
    private func setupLongGestureRecognizerOnTableView() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer: )))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = false
        locationManagerView.favoritesTableView.addGestureRecognizer(longPressedGesture)
    }
}

extension LocationManagementViewContorller: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard locationManagerView.favoritesTableView.isEditing else {
            return [UIDragItem(itemProvider: NSItemProvider())]
        }
        return []
    }
}

// MARK:- UITableView UITableViewDropDelegate
extension LocationManagementViewContorller: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if locationManagerView.favoritesTableView.isEditing, session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        guard locationManagerView.favoritesTableView.isEditing else {
            return
        }
    }
}


extension LocationManagementViewContorller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.locationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = locationManagerView.favoritesTableView.dequeueReusableCell(withIdentifier: LocationManagementViewTableViewCell.identifier) as? LocationManagementViewTableViewCell else { return UITableViewCell() }
        
        let locationList = locationList[indexPath.row]
        
        cell.updateWeather(for: locationList)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard locationManagerView.favoritesTableView.isEditing else {
            print("\(sourceIndexPath.row) -> \(destinationIndexPath.row)")
            let moveCell = self.locationList[sourceIndexPath.row]
            self.locationList.remove(at: sourceIndexPath.row)
            self.locationList.insert(moveCell, at: destinationIndexPath.row)
            return
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = self.persistentContainer.viewContext
            let favoritesToRemove = locationList[indexPath.row]
            context.delete(favoritesToRemove)
            do {
                try context.save()
                locationList.remove(at: indexPath.row)
                locationManagerView.favoritesTableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("한줄 삭제에 실패했습니다: \(error.localizedDescription)")
            }
        } else if editingStyle == .insert {
            
        }
    }
}
