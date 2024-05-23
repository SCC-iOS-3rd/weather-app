//
//  AlarmViewController.swift
//  BringYourUmbrella
//
//  Created by 김준철 on 5/23/24.
// 처음 들어올때 코어데이터 불러오기


import UIKit
import CoreData
import SnapKit

class AlarmViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var collectionView: UICollectionView!
    var alarms: [AlarmData] = []
    
    struct Alarm{
        let time: Date
        let isOn: Bool
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupAddButton()
        
        view.backgroundColor = UIColor(red: 103/255, green: 198/255, blue: 227/255, alpha: 1.0)
        
        collectionView.dataSource = self
        loadAlarmData()
        
        self.navigationItem.title = "알람 설정"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        // 타이틀 색상 변경
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // 네비게이션 바 아이템 색상 변경
        self.navigationController?.navigationBar.tintColor = .white
        
        self.navigationController?.isNavigationBarHidden = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
          
    @objc private func backButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
            mainViewController.modalPresentationStyle = .fullScreen
            self.present(mainViewController, animated: true, completion: nil)
        }
    }


    func setupCollectionView() {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 20, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AlarmCell.self, forCellWithReuseIdentifier: "AlarmCell")
        
        
        collectionView.backgroundColor = UIColor(red: 103/255, green: 198/255, blue: 227/255, alpha: 1.0)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAlarm))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addAlarm() {
        let addAlarmVC = AddAlarmViewController()
        addAlarmVC.onSave = { [weak self] time in
            //let newAlarm = Alarm(time: time, isOn: true)
            //self?.alarms.append(newAlram)
            self?.saveAlarm(time: time, isOn: true)
            self?.alarms = self?.fetchAlarms() ?? []
            self?.sortAlarms()
            self?.collectionView.reloadData()
        }
        addAlarmVC.modalPresentationStyle = .custom
        present(addAlarmVC, animated: true, completion: nil)
    }
    
    func sortAlarms() {
        alarms.sort { $0.time! < $1.time! }
    }
    
    func saveAlarm(time: Date, isOn: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        let context = appDelegate.persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: "AlarmData", in: context) {
          let alarmData = AlarmData(entity: entity, insertInto: context)
          alarmData.time = time
          alarmData.isOn = isOn
          do {
            try context.save()
          } catch let error as NSError {
            print("저장 실패. \(error), \(error.userInfo)")
          }
        }
      }

    func fetchAlarms() -> [AlarmData] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<AlarmData>(entityName: "AlarmData")
        
        do {
            let alarmDataList = try context.fetch(fetchRequest)
            return alarmDataList
        } catch let error as NSError {
            print("불러오기 실패. \(error), \(error.userInfo)")
            return []
        }
    }
    // 이부분 이어서 진행
    func loadAlarmData(){
        
    }


    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alarms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlarmCell", for: indexPath) as! AlarmCell
        let alarm = alarms[indexPath.item]
        
        cell.timeLabel.text = alarm.timeString() //여기서 계산하거나 timestring 함수를 다른곳에 사용하거나
        cell.alarmSwitch.isOn = alarm.isOn
        cell.delegate = self
        
        cell.backgroundColor = .white
        
        return cell
    }
    class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            let attributes = super.layoutAttributesForElements(in: rect)
            
            var leftMargin = sectionInset.left
            var maxY: CGFloat = -1.0
            attributes?.forEach { layoutAttribute in
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }
                
                layoutAttribute.frame.origin.x = leftMargin
                
                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
                maxY = max(layoutAttribute.frame.maxY, maxY)
            }
            
            return attributes
        }
    }

}
extension AlarmViewController: UICollectionViewDelegateFlowLayout {
    // 셀 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 2
        // 높이는 원하는 대로 설정
        let height: CGFloat = 50 // 높이
        return CGSize(width: width, height: height)
    }
}


extension AlarmViewController: AlarmCellDelegate {
    func alarmSwitchDidChangeState(isOn: Bool) {
        // Switch 상태 변경에 대한 처리 로직 구현
    }
    func collectionView(_ collectionView: UICollectionView, trailingSwipeActionsConfigurationForItemAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 삭제 액션 생성
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completionHandler) in
            // 알람 삭제 로직
            self.alarms.remove(at: indexPath.item)
            collectionView.deleteItems(at: [indexPath])
            
            completionHandler(true)
        }
        print("delete")
        // 스와이프 액션에 삭제 액션 추가
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
        
    }
}

