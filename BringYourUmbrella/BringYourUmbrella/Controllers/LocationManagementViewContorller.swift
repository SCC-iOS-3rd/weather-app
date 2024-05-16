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
    let locationManagerViewTableViewCell = LocationManagementViewTableViewCell()
    
    var testData: [String] = ["서울특별시 강남구", "서울특별시 송파구", "서울특별시 광진구"]
    
    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    weak var delegate: LocationManagementDelegate?
    
    // MARK: - methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        locationManagerView.favoritesTableView.dataSource = self
        locationManagerView.favoritesTableView.delegate = self
        locationManagerView.favoritesTableView.register(LocationManagementViewTableViewCell.self, forCellReuseIdentifier: LocationManagementViewTableViewCell.identifier)
        setupLongGestureRecognizerOnTableView()
    }
    
    override func loadView() {
        view = locationManagerView
    }
    
    private func setAddTarget() {
        locationManagerView.bottomSearchButton.addTarget(self, action: #selector(tappedSearchBtn), for: .touchUpInside)
        locationManagerView.currentLocationButton.addTarget(self, action: #selector(tappedCurrentLocation), for: .touchUpInside)
        locationManagerView.favoritesEditButton.addTarget(self, action: #selector(tappedEditButton), for: .touchUpInside)
    }
    
    //    func fetchLocations() {
    //        let context = persistentContainer.viewContext
    //         코어데이터 생성 후 Entity의 이름으로 변경해줄것
    //        let fetchRequest: NSFetchRequest<Locations> = Locations.fetchRequest()
    //
    //        do {
    //            Favorites = try context.fetch(fetchRequest)
    //        } catch {
    //            print("Failed to fetch saved Locations: \(error.localizedDescription)")
    //        }
    //    }
    
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
        let location = gestureRecognizer.location(in: locationManagerView.favoritesTableView)
        
        if gestureRecognizer.state == .began {
            tappedEditButton()
        } else if gestureRecognizer.state == .ended {
            // 롱 프레스 터치가 끝날 떄
        } else {
            return
        }
    }
}

protocol LocationManagementDelegate: AnyObject {
    func didSelectLocation(_ location: String)
}


// MARK: - extensions
extension LocationManagementViewContorller: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = locationManagerView.favoritesTableView.cellForRow(at: indexPath) as? LocationManagementViewTableViewCell else {
            return
        }
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
        self.testData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = locationManagerView.favoritesTableView.dequeueReusableCell(withIdentifier: LocationManagementViewTableViewCell.identifier) as? LocationManagementViewTableViewCell else { return UITableViewCell() }
        // 데이터가 바뀌면 갈아끼워줄 것
        cell.favoritesLocation.text = testData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard locationManagerView.favoritesTableView.isEditing else {
            // 데이터가 바뀌면 갈아끼워줄것
            print("\(sourceIndexPath.row) -> \(destinationIndexPath.row)")
            let moveCell = self.testData[sourceIndexPath.row]
            self.testData.remove(at: sourceIndexPath.row)
            self.testData.insert(moveCell, at: destinationIndexPath.row)
            return
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 데이터가 바뀌면 갈아끼워줄것
        if editingStyle == .delete {
            let context = self.persistentContainer?.viewContext
            //            let favoritesToRemove = testData[indexPath.row]
            //            context.delete(favoritesToRemove)
            do {
                try context?.save()
                testData.remove(at: indexPath.row)
                locationManagerView.favoritesTableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("한줄 삭제에 실패했습니다: \(error.localizedDescription)")
            }
        } else if editingStyle == .insert {
            
        }
    }
}
