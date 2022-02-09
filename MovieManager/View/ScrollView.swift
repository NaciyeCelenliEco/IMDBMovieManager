//
//  ScrollView.swift
//  MovieManager
//
//  Created by Naciye Celenli on 9.02.2022.
//


import UIKit

class ScrollView: UIScrollView {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
        
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        }
        
    }

}

