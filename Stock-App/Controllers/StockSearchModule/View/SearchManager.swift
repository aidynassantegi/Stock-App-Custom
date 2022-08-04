//
//  SearchManager.swift
//  Stock-App
//
//  Created by Aidyn Assan on 04.08.2022.
//

import UIKit

class SearchManager: NSObject, UISearchResultsUpdating, UISearchBarDelegate {
    
    var searchForQuery: ((String) -> Void)?
    var canselSearch: (() -> Void)?
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let lastSearch = searchBar.text,
                !lastSearch.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        canselSearch?()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        searchForQuery?(query)
    }
}
