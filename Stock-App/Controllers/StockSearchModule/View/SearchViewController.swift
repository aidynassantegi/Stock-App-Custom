//
//  SearchVC.swift
//  Stock App
//
//  Created by Aidyn Assan on 19.07.2022.
//

import UIKit

protocol SearchViewInput: AnyObject {
    func setSearcResults(with stocks: [TableViewModel])
}

protocol SearchViewOutput: AnyObject {
    func searchFor(query: String)
}

class SearchViewController: UIViewController, SearchViewInput {
    
    var output: SearchViewOutput?
    
    var searchManager: SearchManager!
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(StockTableViewCell.self,
                           forCellReuseIdentifier: StockTableViewCell.reuseId)
        return tableView
    }()
    
    var searchResults: [TableViewModel] = []
    
    func setSearcResults(with stocks: [TableViewModel]) {
        searchResults = stocks
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
        searchManager.searchForQuery = { [weak self] query in
            self?.output?.searchFor(query: query)
        }
        searchManager.canselSearch = { [weak self] in
            let _ = self?.searchResults.first
            self?.searchResults = []
            self?.tableView.reloadData()
        }
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search for a stock"
        searchController.searchBar.delegate = searchManager
        searchController.searchResultsUpdater = searchManager
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





