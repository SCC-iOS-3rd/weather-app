//
//  AddAlarmViewController.swift
//  BringYourUmbrella
//
//  Created by 김준철 on 5/23/24.
//

import UIKit

class AddAlarmViewController: UIViewController {
    
    let datePicker = UIDatePicker()
    let backButton = UIButton()
    
    let containerView = UIView()
    var onSave: ((Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        backButton.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle(nil, for: .normal)
        
        view.addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            backButton.heightAnchor.constraint(equalTo: view.heightAnchor),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 400),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        setupDatePicker()
        setupButtons()
    }
    
    func setupDatePicker() {
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    func setupButtons() {
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        let addButton = UIButton(type: .system)
        addButton.setTitle("추가", for: .normal)
        addButton.addTarget(self, action: #selector(addAlarm), for: .touchUpInside)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cancelButton)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50),
            addButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50),
            cancelButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20)
        ])
        
    }
    
    @objc func addAlarm() {
        //let newAlarm = AlarmViewController.Alarm(time: datePicker.date) // AlarmViewController 안에 알람 없음
        let time = datePicker.date
        
        
        onSave?(time)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
}
