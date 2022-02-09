//
//  BaseViewController.swift
//  MovieManager
//
//  Created by Naciye Celenli on 6.02.2022.
//

import UIKit
import SnapKit
import MBProgressHUD

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    var hud: MBProgressHUD? = nil
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.clipsToBounds = true;
        self.view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.delegate = self;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated);
        
    }
    
    public func showLoading(){
        hideLoading();
        DispatchQueue.main.async {
            self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            if let hudd = self.hud{
            hudd.mode = .annularDeterminate
            hudd.bezelView.color = UIColor.gray.withAlphaComponent(0.3)
            hudd.bezelView.style = .solidColor
        }
        }
    }
    public func hideLoading() {
        DispatchQueue.main.async {
            if let hudd = self.hud {
                hudd.hide(animated: true)
            }
        }
    }
    
}
extension BaseViewController {
    
    func layoutNavigation(){
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
    }
    
}
