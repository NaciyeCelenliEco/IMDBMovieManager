//
//  DetailViewController.swift
//  MovieManager
//
//  Created by Naciye Celenli on 8.02.2022.
//

import UIKit
import SnapKit

class DetailViewController: BaseViewController {
    lazy public var movieId : Int = 0
    lazy private var movieTitle : String = ""
    lazy private var orgTitle : String = ""
    lazy private var average : String = ""
    lazy private var desc : String = ""
    lazy private var date : String = ""
    lazy private var imagePath: String = ""
    lazy private var listButton = UIButton()
    lazy private var favButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieDetail()
        
    }
    func fetchMovieDetail() {
        //showLoading()
        let req = RequestObj()
        AppRequestManager().get(.movieDetail(movieId: movieId), MovieDetail.self, req.toJSON()) { (data, error) in
            //self.hideLoading()
            if let err = error {
                print(err)
            }else {
                if let result = data {
                    self.average =  String(format: "%.1f", result.voteAverage)
                    self.movieTitle = result.title
                    self.desc = result.overview
                    self.date = result.releaseDate
                    self.orgTitle = result.originalTitle
                    self.imagePath = result.backdropPath
                    
                    self.setUI()
                }
            }
        }
    }
    func setUI(){
        let scroll = ScrollView()
        self.view.addSubview(scroll);
               scroll.snp.makeConstraints { (make) in
                   make.top.equalToSuperview()
       //            make.top.equalToSuperview()
                   make.left.right.equalToSuperview()
                   make.centerX.equalToSuperview()
                  make.bottom.equalToSuperview()
               }
               let contentView = UIView()
               scroll.addSubview(contentView)
               contentView.snp.makeConstraints { (make) in
                   make.top.equalToSuperview()
                   make.bottom.equalToSuperview()
                   make.left.right.equalToSuperview()
                   make.centerX.equalToSuperview()
                   make.height.greaterThanOrEqualTo(0)
               }
               
              
        let imageUrl = URL(string: String(format: "%@%@", "https://image.tmdb.org/t/p/w500/",imagePath))
        let imageBack = UIView()
        
        contentView.addSubview(imageBack)
        imageBack.snp.makeConstraints{(make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(self.view.safeAreaLayoutGuide.snp.width).multipliedBy(0.6)
        }
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.load(url: imageUrl!)
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints{(make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(self.view.safeAreaLayoutGuide.snp.width).multipliedBy(0.5)
            
        }
        
//        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(scrollView)
//        scrollView.snp.makeConstraints { (make) in
//            make.top.leading.trailing.equalToSuperview()
//        }
//
        let starView = UIView()
        contentView.addSubview(starView)
        starView.snp.makeConstraints{(make) in
            make.top.equalTo(imageBack.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(75)
        }
        
        let titlelbl = UILabel()
        titlelbl.text = orgTitle
        titlelbl.numberOfLines = 2
        titlelbl.font = UIFont.boldSystemFont(ofSize: 20.0)
        starView.addSubview(titlelbl)
        titlelbl.snp.makeConstraints{(make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(45)
        }
        
        let starImgView = UIImageView()
        starImgView.image = UIImage(named: "star")
        starView.addSubview(starImgView)
        starImgView.snp.makeConstraints{(make) in
            make.top.equalTo(titlelbl.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(15)
        }
        
        let avgLbl = UILabel()
        avgLbl.text = average
        avgLbl.font = UIFont.systemFont(ofSize: 12)
        starView.addSubview(avgLbl)
        avgLbl.snp.makeConstraints{(make) in
            make.top.equalTo(titlelbl.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(40)
            make.height.equalTo(15)
        }
        
        let dateLbl = UILabel()
        dateLbl.text = convertStringDateToStringDate(strDate: date, inFormat: Constants.Date.serviceFormat, outFormat: Constants.Date.outFormat)
        dateLbl.font = UIFont.systemFont(ofSize: 12)
        starView.addSubview(dateLbl)
        dateLbl.snp.makeConstraints{(make) in
            make.top.equalTo(titlelbl.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(15)
        }
        
        let descView = UITextView()
        descView.text = desc
        descView.font = UIFont.systemFont(ofSize: 15)
        descView.isUserInteractionEnabled =  false
        contentView.addSubview(descView)
        descView.snp.makeConstraints{(make) in
            make.top.equalTo(starView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(150)
        }
        
        let buttonView = UIView()
        buttonView.backgroundColor = UIColor(red: 186/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0)
        self.view.addSubview(buttonView)
        buttonView.snp.makeConstraints{(make) in
            make.top.equalTo(scroll.snp.bottom).offset(-60)
            make.left.right.equalToSuperview()
            make.height.equalTo(60)
        }
        
        listButton = UIButton()
        let listImage = UIImage(named: "list")
        listButton.setImage(listImage , for: .normal)
        listButton.addTarget(self, action: #selector(addWatchlist), for: UIControl.Event.touchUpInside)
        buttonView.addSubview(listButton)
        listButton.snp.makeConstraints{(make) in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(50)
        }
        
        favButton = UIButton()
        let favImage = UIImage(named: "heart")
        favButton.setImage(favImage , for: .normal)
        favButton.addTarget(self, action: #selector(addFavorite), for: UIControl.Event.touchUpInside)
        buttonView.addSubview(favButton)
        favButton.snp.makeConstraints{(make) in
            make.top.equalToSuperview().offset(5)
            make.left.equalTo(listButton.snp.right).offset(20)
            make.width.height.equalTo(50)
        }
        
    }
    
    @objc func addFavorite() {
        //showLoading()
        favButton.isEnabled = false
        let req = FavRequest()
        req.mediaID = movieId
        req.mediaType = "movie"
        req.favorite = true
        
        print(req)
        AppRequestManager().get(.addFavorite(accountId: UserManager.accountId, sessionId: UserManager.sessionId), AddFavorite.self, req.toJSON()) { (data, error) in
            //self.hideLoading()
            if error != nil {
                
                self.showAlert(message: "Failure adding to favorites")
                self.favButton.isEnabled = true
                
            }else {
                self.showAlert(message: "Movie added to your favorites")
                
            }
        }
    }
    
    @objc func addWatchlist() {
        //showLoading()
        listButton.isEnabled = false
        let req = WatchlistRequest()
        req.mediaID = movieId
        req.mediaType = "movie"
        req.watchlist = true
        
        AppRequestManager().get(.addWatchlist(accountId: UserManager.accountId, sessionId: UserManager.sessionId), AddWatchlist.self, req.toJSON()) { (data, error) in
           // self.hideLoading()
            if error != nil {
                self.showAlert(message:"Failure adding to watchlist")
                self.listButton.isEnabled = true
                
            }else {
                self.showAlert(message: "Movie added to your watchlist")
            }
        }
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func convertStringDateToStringDate(strDate: String, inFormat: String, outFormat: String) -> String {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = inFormat;
        let date = dateFormatter.date(from: strDate);
        dateFormatter.dateFormat = outFormat;
        
        if date != nil {
            return dateFormatter.string(from: date!);
        } else {
            return strDate
        }
    }
    
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}



