//
//  CustomCell.swift
//  MovieManager
//
//  Created by Naciye Celenli on 9.02.2022.
//
import UIKit

class CustomCell: UITableViewCell {
    static var cellId = "cell"
    
    let lblTitle: UILabel = {
        let v = UILabel()
        v.textColor = .black
        v.textAlignment = .left
        v.layer.masksToBounds = true
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.addSubview(lblTitle)
        lblTitle.snp.makeConstraints { (make) in
            make.top.left.equalTo(10)
            make.right.bottom.equalTo(-10)
        }
    }
}
