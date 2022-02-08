//
//  TableView.swift
//  MovieManager
//
//  Created by Naciye Celenli on 7.02.2022.
//

import UIKit

class TableView: UITableView {
    
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height + 20)
    }
    
}
