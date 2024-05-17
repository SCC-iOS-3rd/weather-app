//
//  LocationManagementViewContorller.swift
//  BringYourUmbrella
//
//  Created by Kinam on 5/13/24.
//

import UIKit

class LocationManagementViewContorller: UIViewController {
    // MARK: - properties
    let locationManagerView = LocationManagementView()
    
    let testData: [String] = ["송파구 잠실동", "강남구 서초동", "강남구 대치동"]
    
    //위도와 경도
    var latitude: Double = 0.0
    var longitude: Double = 0.0
  
    
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
    
    @objc private func tappedSearchBtn() {
        let nextVc = LocationSearchViewController()
        nextVc.modalPresentationStyle = .pageSheet
        present(nextVc, animated: true)
    }
    
    @objc private func tappedCurrentLocation() {
        print("현재 위치")
    }
    
    @objc private func tappedEditButton() {
        if locationManagerView.favoritesTableView.isEditing {
            locationManagerView.favoritesEditButton.setTitle("편집", for: .normal)
            locationManagerView.favoritesTableView.setEditing(false, animated: true)
        } else {
            locationManagerView.favoritesTableView.dragInteractionEnabled = true
            locationManagerView.favoritesTableView.dragDelegate = self
            locationManagerView.favoritesTableView.dropDelegate = self
            locationManagerView.favoritesEditButton.setTitle("완료", for: .normal)
            locationManagerView.favoritesTableView.setEditing(true, animated: true)
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
}

// MARK: - extensions
extension LocationManagementViewContorller: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
}

extension LocationManagementViewContorller: UIGestureRecognizerDelegate {
    private func setupLongGestureRecognizerOnTableView() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer: )))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        locationManagerView.favoritesTableView.addGestureRecognizer(longPressedGesture)
    }
    
    
}

extension LocationManagementViewContorller: UITableViewDragDelegate {
func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}
 
// MARK:- UITableView UITableViewDropDelegate
extension LocationManagementViewContorller: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) { }
}


extension LocationManagementViewContorller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.testData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = locationManagerView.favoritesTableView.dequeueReusableCell(withIdentifier: LocationManagementViewTableViewCell.identifier) as? LocationManagementViewTableViewCell else { return UITableViewCell() }
        cell.favoritesLocation.text = testData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    
}
