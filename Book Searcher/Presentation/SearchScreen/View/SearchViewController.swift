//
//  SearchViewController.swift
//  Book Searcher
//
//  Created by Ibrokhim Shukrullaev on 9/11/21.
//

import UIKit

class SearchViewController: UIViewController {
    private let viewModel: SearchViewModel

    //MARK: - Init
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        viewModel.delegate = self
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
    
    private func openDetailViewController(with viewModel: DetailViewModel) {
        let detailVC = DetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


//MARK: - SearchController Delegate Methods
extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            viewModel.loadBooks(with: searchText)
            
            if searchText.isEmpty {
                clearTableView()
            }
        }
    }
    
    private func clearTableView() {
        viewModel.booksCount = 0
        tableView.reloadData()
    }
}

//MARK: - TableView Delegate Methods
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.booksCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookViewCell.cellID, for: indexPath) as? BookViewCell else  {
            return UITableViewCell()
        }
        let index = indexPath.row
        cell.setContent(title: viewModel.getTitle(at: index), authors: viewModel.getAuthorsList(at: index), thumbNail: viewModel.getThumnail(at: index))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let detailViewModel = DetailViewModel(title: viewModel.getTitle(at: index), authors: viewModel.getAuthorsList(at: index), imageURL: viewModel.getThumnail(at: index))
        openDetailViewController(with: detailViewModel)
    }
}

extension SearchViewController: SearchViewDelegate {
    func renderView() {
        tableView.reloadData()
    }
}

