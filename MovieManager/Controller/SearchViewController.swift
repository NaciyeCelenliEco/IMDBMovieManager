//
//  SearchViewController.swift
//  MovieManager
//
//  Created by Naciye Celenli on 6.02.2022.
//

import UIKit

class SearchViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    lazy var tbl: UITableView = {
        let v = UITableView()
        v.rowHeight = 40
        v.separatorStyle = .singleLine
        return v
    }()
    lazy var searchBar:UISearchBar = UISearchBar()
    
    var items: [Search.SearchResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        tbl.delegate = self
        tbl.dataSource = self
        tbl.register(CustomCell.self, forCellReuseIdentifier: CustomCell.cellId)
        self.view.addSubview(tbl)
        tbl.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.cellId, for: indexPath) as! CustomCell
        cell.lblTitle.text = items[indexPath.row].title
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        showLoading()
        let req = SearchRequest()
        print(req)
        AppRequestManager().get(.search(query: textSearched), Search.self, req.toJSON()) { (data, error) in
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
}


