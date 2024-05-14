//
//  LocationSearchViewController.swift
//  BringYourUmbrella
//
//  Created by 희라 on 5/13/24.
//

import UIKit
import SnapKit


class LocationSearchViewController: UIViewController {
    
    let locationSearchBar = UISearchBar()
    let locationSearchResultTableView = UITableView()
    
    //데이터모델
    //var searchResults = []()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupConstraints()
        configureUI()
        
        locationSearchResultTableView.dataSource = self
        locationSearchResultTableView.delegate = self
        locationSearchResultTableView.register(LocationSearchResultTableViewCell.self, forCellReuseIdentifier: "SearchResultTableViewCell")

    }//override func viewDidLoad
    
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
        
        locationSearchResultTableView.backgroundColor = .lightGray
        
    }//func configureUI

}


extension LocationSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as! LocationSearchResultTableViewCell
        
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

        
        
//        //API매니저 호출 추가 예정
//        [api매니저 이름].fetchqueryAPI(with: searchText) { result in
//            switch result {
        
//        //성공적으로 locationInfo를 받아온 경우
//            case .success(let locationInfo):
//
//                print("😺😺😺", "Received LocationInfo: \(locationInfo)")
//
//                //배열의 내용을 검색결과로 바꿔라
//                self.searchResults = locationInfo.documents
//
//                //테이블뷰를 업데이트해라
//                DispatchQueue.main.async {
//                    self.searchResultTableView.reloadData()
//                }
//                                
//        //locationInfo를 받아오지 못한 경우
//            case .failure(let error):
//                print("👹👹👹", "Error fetching LocationInfo: \(error)")
//            }
//        }
        
    }
    
}

extension LocationSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let PreviewVC = NewLocationPreviewViewController()

        present(PreviewVC, animated: true, completion: nil)
        }
}
