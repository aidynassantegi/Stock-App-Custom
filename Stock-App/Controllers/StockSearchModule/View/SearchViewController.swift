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

class SearchViewController: UIViewController, SearchViewInput {
    
    var output: SearchViewOutput?
    
    var searchManager: SearchManager!
    
    var searchResults: [TableViewModel] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(StockTableViewCell.self,
                           forCellReuseIdentifier: StockTableViewCell.reuseId)
        return tableView
    }()
    
    
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
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
    
    private func setupTableView() {
        view.addSubview(tableView)
        searchManager.setCellWithStock = { [weak self] index in
            self?.searchResults[index]
        }
        searchManager.searchResultCount = { [ weak self ] in
            self?.searchResults.count ?? 0
        }
        tableView.delegate = searchManager
        tableView.dataSource = searchManager
    }
}







