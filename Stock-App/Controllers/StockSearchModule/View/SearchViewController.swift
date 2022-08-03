//
//  SearchVC.swift
//  Stock App
//
//  Created by Aidyn Assan on 19.07.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    var presenter: SearchPresenter?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(StockTableViewCell.self,
                           forCellReuseIdentifier: StockTableViewCell.reuseId)
        return tableView
    }()
    
    var searchResults: [TableViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchVC()
//        configureSearchedBeforeCV()
        setupTableView()
    }
    
    func configureSearchVC() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search for a stock"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }

//    func configureSearchedBeforeCV() {
//        guard let searchedColection = searchedColection else { return }
//        let searchedView = UIView()
//        add(childVC: searchedColection, to: searchedView)
//        searchedView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(searchedView)
//        NSLayoutConstraint.activate([
//            searchedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            searchedView.heightAnchor.constraint(equalToConstant: 122),
//            searchedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            searchedView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: StockTableViewCell.reuseId,
            for: indexPath) as! StockTableViewCell
        
        cell.configure(with: searchResults[indexPath.row], index: indexPath.row)
        
        return cell
    }
    
    
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
//        presenter?.searchFor(query: query)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let lastSearch = searchBar.text,
                !lastSearch.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        searchResults = []
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        presenter?.searchFor(query: query)
    }
}


