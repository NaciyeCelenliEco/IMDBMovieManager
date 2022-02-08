//
//  LoginIconView.swift
//  MovieManager
//
//  Created by Naciye Celenli on 7.02.2022.
//

import UIKit

class LoginIconView: UIView {
    
    lazy private var cameraImg = UIImageView()
    lazy private var titleLabel = UILabel()
    var gap = 40
    
    override func layoutSubviews() {
        
        
        cameraImg.image = UIImage(named: "camera_video")
        self.addSubview(cameraImg)
        cameraImg.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(2*gap)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        
        titleLabel.text = "The Movie Manager"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{(make) in
            make.top.equalTo(cameraImg.snp.bottom).offset(gap/2)
            make.centerX.equalToSuperview()
            
        }
        
    }
    
}

