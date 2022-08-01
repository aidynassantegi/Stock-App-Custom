//
//  SearchVC.swift
//  Stock App
//
//  Created by Aidyn Assan on 19.07.2022.
//

import UIKit

class SearchVC: UIViewController {
    
    var searchResultVC: SearchResultVC?
    var searchManager: SearchVCManager?
    var searchedColectionVC: SearchedColectionVC?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchVC()
        configureSearchedBeforeCV()
    }
    
    func configureSearchVC() {
        guard let searchResultVC = searchResultVC else { return }
        let searchController = UISearchController(searchResultsController: searchResultVC)
        searchController.searchBar.placeholder = "Search for a stock"
        searchController.searchBar.delegate = searchManager
        searchController.searchResultsUpdater = searchManager
        navigationItem.searchController = searchController
    }

    func configureSearchedBeforeCV() {
        guard let searchedColectionVC = searchedColectionVC else { return }
//        searchManager?.searchCollectionVC = searchedColectionVC
        let searchedCVView = UIView()
        add(childVC: searchedColectionVC, to: searchedCVView)
        searchedCVView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchedCVView)
        NSLayoutConstraint.activate([
            searchedCVView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchedCVView.heightAnchor.constraint(equalToConstant: 122),
            searchedCVView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchedCVView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

class SearchVCManager: NSObject, UISearchResultsUpdating, UISearchBarDelegate {
//    var presenter: SearchPresenter?
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else { return    }
        presenter?.searchFor(query: query)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let lastSearch = searchBar.text,
                !lastSearch.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        presenter?.append(lastSearch: lastSearch)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else { return    }
        presenter?.searchFor(query: query)
    }
}
