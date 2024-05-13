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
        locationManagerView.searchButton.addTarget(self, action: #selector(tappedSearchBtn), for: .touchUpInside)
    }
    
    @objc private func tappedSearchBtn() {
        let nextVc = LocationSearchViewController()
        nextVc.modalPresentationStyle = .pageSheet
    }
}

// MARK: - extensions
extension LocationManagementViewContorller: UITableViewDelegate {
    
}

extension LocationManagementViewContorller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
