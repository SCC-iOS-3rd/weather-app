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
    
    
    // MARK: - methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        locationManagerView.favoritesTableView.dataSource = self
        locationManagerView.favoritesTableView.delegate = self
    }
    
    override func loadView() {
        view = locationManagerView
    }
    
    private func setAddTarget() {
        locationManagerView.bottomSearchButton.addTarget(self, action: #selector(tappedSearchBtn), for: .touchUpInside)
        locationManagerView.currentLocationButton.addTarget(self, action: #selector(tappedCurrentLocation), for: .touchUpInside)
    }
    
    @objc private func tappedSearchBtn() {
        let nextVc = LocationSearchViewController()
        nextVc.modalPresentationStyle = .pageSheet
        present(nextVc, animated: true)
    }
    
    @objc private func tappedCurrentLocation() {
        print("현재 위치")
    }
}

// MARK: - extensions
extension LocationManagementViewContorller: UITableViewDelegate {
    
}

extension LocationManagementViewContorller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = locationManagerView.favoritesTableView.dequeueReusableCell(withIdentifier: LocationManagementViewTableViewCell.identifier) as? LocationManagementViewTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    
}
