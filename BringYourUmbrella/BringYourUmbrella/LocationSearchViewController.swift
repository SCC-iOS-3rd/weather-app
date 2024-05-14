//
//  LocationSearchViewController.swift
//  BringYourUmbrella
//
//  Created by 희라 on 5/13/24.
//

// ⭐️ 장소검색 ⭐️

import UIKit
import SnapKit
import MapKit


class LocationSearchViewController: UIViewController {
    
    let locationSearchBar = UISearchBar()
    let locationSearchResultTableView = UITableView()
    

    private var searchCompleter = MKLocalSearchCompleter() // 검색을 도와주는 변수
    private var searchResults = [MKLocalSearchCompletion]() // 검색결과
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupConstraints()
        configureUI()
        
        setupSearchCompleter()
        
        locationSearchBar.delegate = self
        
        locationSearchResultTableView.rowHeight = 50
        locationSearchResultTableView.dataSource = self
        locationSearchResultTableView.delegate = self
        locationSearchResultTableView.register(LocationSearchResultTableViewCell.self, forCellReuseIdentifier: "SearchResultTableViewCell")

    }//override func viewDidLoad
    
    
    func setupSearchCompleter() {
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address/// resultTypes은 검색 유형인데 address는 주소를 의미
    }
    
    func setupConstraints() {
        [locationSearchBar, locationSearchResultTableView].forEach {
            view.addSubview($0)
        }
        
        locationSearchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        locationSearchResultTableView.snp.makeConstraints { make in
            make.top.equalTo(locationSearchBar.snp.bottom)
            make.leading.equalTo(locationSearchBar)
            make.trailing.equalTo(locationSearchBar)
            make.bottom.equalToSuperview().inset(10)
        }
        
        
    }//func setupConstraints
    
    
    func configureUI() {
        locationSearchBar.placeholder = "지금, 날씨가 궁금한 곳은?"
        //locationSearchResultTableView.backgroundColor = .lightGray
        
    }//func configureUI

}


extension LocationSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as! LocationSearchResultTableViewCell
        
        cell.locationName.text = searchResults[indexPath.row].title
        
        return cell
    }
}//TableViewDataSource



extension LocationSearchViewController: UISearchBarDelegate {
    private func dismissKeyboard() {
        locationSearchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //입력 텍스트가 있을때만 리턴버튼 활성화
        guard let searchText = searchBar.text, searchText.isEmpty == false else { return }
        
        //키보드 종료
        dismissKeyboard()
    }
    
    // searchText를 queryFragment로 이관
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
        print(searchResults)
    }
    
    
    //위도와 경도 추출
    func mkLocalSearch(indexPath: IndexPath) {
        let selectedCompletion = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: selectedCompletion)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { (response, error) in
            if let error = error {
                print("검색 중 오류 발생: \(error.localizedDescription)")
                return
            }
            
            if let response = response, let mapItem = response.mapItems.first {
                let coordinate = mapItem.placemark.coordinate
                print("선택장소: \(selectedCompletion)", "선택된 장소의 위도: \(coordinate.latitude), 경도: \(coordinate.longitude)")
            }
        }
    }
}

extension LocationSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        mkLocalSearch(indexPath: indexPath)
        
        let PreviewVC = NewLocationPreviewViewController()
        
        present(PreviewVC, animated: true, completion: nil)
    }
}

extension LocationSearchViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // completer.results를 통해 검색한 결과를 searchResults에 담아줍니다
        searchResults = completer.results
        locationSearchResultTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // 에러 확인
        print(error.localizedDescription)
    }
}
