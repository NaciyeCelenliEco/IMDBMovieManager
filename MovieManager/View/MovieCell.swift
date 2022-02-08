//
//  MovieCell.swift
//  MovieManager
//
//  Created by Naciye Celenli on 9.02.2022.
//

import UIKit

class MovieCell: UITableViewCell {
    static var cellId = "cell"
    private lazy var imgView = UIImageView()
    
    let lblTitle: UILabel = {
        let v = UILabel()
        v.textColor = .black
        v.textAlignment = .left
        v.layer.masksToBounds = true
        return v
    }()
    
    public var imagePath: String? {
        didSet {
            if let m = imagePath {
                let imageUrl = URL(string: String(format: "%@%@", "https://image.tmdb.org/t/p/w500/",m))
                imgView.load(url: imageUrl!)
                setNeedsLayout()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        
        imgView.contentMode = .scaleAspectFit
        self.addSubview(imgView)
        imgView.snp.makeConstraints{(make) in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalTo(self.snp.left).offset(50)
            make.height.equalToSuperview().offset(-10)
            
        }
        
        self.addSubview(lblTitle)
        lblTitle.snp.makeConstraints { (make) in
            make.left.equalTo(100)
            make.centerY.equalToSuperview()
            make.right.equalTo(10)
        }
    }
}
