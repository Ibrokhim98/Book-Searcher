//
//  SearchViewController.swift
//  Book Searcher
//
//  Created by Ibrokhim Shukrullaev on 9/11/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - Outlets
    private lazy var searchView: UISearchController = {
       let searchView = UISearchController(searchResultsController: nil)
        searchView.obscuresBackgroundDuringPresentation = false
        searchView.searchBar.placeholder = "Search by Title, Author or Series"
        searchView.hidesNavigationBarDuringPresentation = false
        searchView.searchResultsUpdater = self
        return searchView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BookViewCell.self, forCellReuseIdentifier: BookViewCell.cellID)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setViewAppearance()
    }
    
    
    //MARK: - Helper Methods
    private func setUpViews() {
        view.addSubview(tableView)
        navigationItem.searchController = searchView
        tableView.frame = view.bounds
    }
    
    private func setViewAppearance() {
        title = "Books"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}


//MARK: - SearchController Delegate Methods
extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

//MARK: - TableView Delegate Methods
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookViewCell.cellID, for: indexPath) as? BookViewCell else  {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
}

