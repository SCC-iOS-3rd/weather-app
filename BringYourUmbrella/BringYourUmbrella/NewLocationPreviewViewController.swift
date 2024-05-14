//
//  NewLocationPreviewViewController.swift
//  BringYourUmbrella
//
//  Created by t2023-m0114 on 5/13/24.
//

import UIKit

class NewLocationPreviewViewController: UIViewController {
    
    let PreviewtitleLabel = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupConstraints()
        configureUI()

    }
    
    func setupConstraints() {
        [PreviewtitleLabel].forEach {
            view.addSubview($0)
        }
        
        PreviewtitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }

    func configureUI() {
        PreviewtitleLabel.text = "새로운 장소 추가 프리뷰"
    }
    
}
