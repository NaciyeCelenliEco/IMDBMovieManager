//
//  LoginViewController.swift
//  MovieManager
//
//  Created by Naciye Celenli on 6.02.2022.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController, UITextFieldDelegate {
    
    lazy private var lgnIconView = LoginIconView()
    lazy private var lgnButton = UIButton()
    lazy private var txtUsername = UITextView()
    lazy private var txtPassword = UITextField()
    
    var gap = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillAppear(animated)
    }
    func setUI(){
        
        self.view.backgroundColor = UIColor(red: 25/255.0, green: 177/255.0, blue: 240/255.0, alpha: 1.0)
        self.view.addSubview(lgnIconView)
        lgnIconView.snp.makeConstraints{(make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(220)
        }
        
        let usernameLbl = UILabel()
        usernameLbl.text = "Username"
        usernameLbl.font = UIFont.systemFont(ofSize: 12)
        self.view.addSubview(usernameLbl)
        usernameLbl.snp.makeConstraints{(make) in
            make.top.equalTo(lgnIconView.snp.bottom).offset(gap)
            make.left.right.equalToSuperview().inset(gap/2)
            make.height.equalTo(30)
        }
        
        txtUsername.backgroundColor =  UIColor(red: 58/255.0, green: 209/255.0, blue: 250/255.0, alpha: 1.0)
        self.view.addSubview(txtUsername)
        txtUsername.snp.makeConstraints{(make) in
            make.top.equalTo(usernameLbl.snp.bottom)
            make.left.right.equalToSuperview().inset(gap/2)
            make.height.equalTo(30)
        }
        let passwordLbl = UILabel()
        passwordLbl.text = "Password"
        passwordLbl.font = UIFont.systemFont(ofSize: 12)
        self.view.addSubview(passwordLbl)
        passwordLbl.snp.makeConstraints{(make) in
            make.top.equalTo(txtUsername.snp.bottom).offset(gap/2)
            make.left.right.equalToSuperview().inset(gap/2)
            make.height.equalTo(30)
        }
        txtPassword.isUserInteractionEnabled = true
        txtPassword.isSecureTextEntry = true
        
        txtPassword.backgroundColor =  UIColor(red: 58/255.0, green: 209/255.0, blue: 250/255.0, alpha: 1.0)
        self.view.addSubview(txtPassword)
        txtPassword.snp.makeConstraints{(make) in
            make.top.equalTo(passwordLbl.snp.bottom)
            make.left.right.equalToSuperview().inset(gap/2)
            make.height.equalTo(30)
        }
        
        self.view.addSubview(lgnButton)
        lgnButton.setTitle("Login", for: .normal)
        lgnButton.backgroundColor =  UIColor(red: 9/255.0, green: 34/255.0, blue: 141/255.0, alpha: 1.0)
        lgnButton.addTarget(self, action: #selector(loginButtonPressed), for: UIControl.Event.touchUpInside)
        lgnButton.snp.makeConstraints{(make) in
            make.top.equalTo(txtPassword.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    func fetchToken(){
        let req = TokenRequest()
        req.apiKey = Constants.Api.Key
        showLoading()
        AppRequestManager().get(.token, Token.self, req.toJSON()) { (data, error) in
            self.hideLoading()
            if let err = error {
                print(err)
            }else {
                if let result = data {
                    self.fetchLogin(requestToken: result.requestToken)
                }
            }
        }
    }
    func fetchLogin(requestToken: String){
        showLoading()
        let req = LoginRequest()
        req.username = txtUsername.text ?? ""
        req.password = txtPassword.text ?? ""
        req.requestToken = requestToken
        print(req)
        AppRequestManager().get(.login, Login.self, req.toJSON()) { (data, error) in
            self.hideLoading()
            if error != nil {
                let alert = UIAlertController(title: "",
                                              message: "Wrong credentials",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }else {
                if let result = data {
                    self.createSession(requestToken: result.requestToken)
                }
            }
        }
    }
    func createSession(requestToken: String){
        let req = SessionRequest()
        req.requestToken = requestToken
        showLoading()
        AppRequestManager().get(.createSession, CreateSession.self, req.toJSON()) { (data, error) in
            self.hideLoading()
            if let err = error {
                print(err)
            }else {
                if let result = data {
                    if(result.success)
                    {
                        self.getAccount(sessionId: result.sessionId)
                    }
                }
            }
        }
    }
    func getAccount(sessionId: String){
        let req = AccountRequest()
        showLoading()
        AppRequestManager().get(.account(sessionId: sessionId), Account.self, req.toJSON()) { (data, error) in
            self.hideLoading()
            if let err = error {
                print(err)
            }else {
                if let result = data {
                    print(result.id)
                    UserManager.accountId = result.id
                    UserManager.sessionId = sessionId
                    self.navigationController?.setViewControllers([TabbarViewController()], animated: false);
                    
                }
            }
        }
    }
    private func controlForm() -> Bool {
        
        if txtUsername.text!.isEmpty {
            return false
        }
        
        if txtPassword.text!.isEmpty {
            return false
        }
        
        return true
        
    }
    @objc func loginButtonPressed(_ sender: UIButton) {
        if(controlForm())
        {
            fetchToken()
        }
        else{
            let alert = UIAlertController(title: "",
                                          message: "Fill both username and password",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
}
