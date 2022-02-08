//
//  FavoritesViewController.swift
//  MovieManager
//
//  Created by Naciye Celenli on 6.02.2022.
//
import UIKit

class FavoritesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    lazy var tbl: UITableView = {
        let v = UITableView()
        v.rowHeight = 100
        v.separatorStyle = .singleLine
        return v
    }()
    var items: [MovieListResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFavorites()
        setUI()
    }
    func setUI()
    {
        tbl.delegate = self
        tbl.dataSource = self
        tbl.register(MovieCell.self, forCellReuseIdentifier: MovieCell.cellId)
        self.view.addSubview(tbl)
        tbl.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    func fetchFavorites()
    {
        showLoading()
        let req = FavRequest()
        print(req)
        AppRequestManager().get(.getFavorites(accountId: UserManager.accountId, sessionId: UserManager.sessionId), Favorites.self, req.toJSON()) { (data, error) in
            self.hideLoading()
            if let err = error {
                print(err)
            }else {
                if let result = data {
                    self.items=result.results
                    self.tbl.reloadData()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewCont = DetailViewController()
        viewCont.movieId = items[indexPath.row].id
        viewCont.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(viewCont, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.cellId, for: indexPath) as! MovieCell
        cell.lblTitle.text = items[indexPath.row].originalTitle
        cell.imagePath = items[indexPath.row].posterPath
        return cell
    }
    
}
