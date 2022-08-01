//
//  SearchPresenter.swift
//  Stock-App
//
//  Created by Aidyn Assan on 01.08.2022.
//

import Foundation

final class SearchPresenter {
    
    // MARK: - Interactor
    var interactor: SearchInteractor?
    func searchFor(query: String) {
        interactor?.searchStock(with: query)
    }
    
    weak var searchResult: SearchResultVC?
    func setSearchResults(with stocks: [TableViewModel]) {
        searchResult?.searchResults = stocks
    }
    
    // MARK: - View
    
    // Search results
    
    
    // Last searched stocks
    weak var searchedColectionVC: SearchedColectionVC?
    private var lastSearchedStocks = [String]()
    func append(lastSearch: String) {
        lastSearchedStocks.insert(lastSearch, at: 0)
        searchedColectionVC?.tickets = lastSearchedStocks
    }
    
    // Future works with view
    
    // MARK: - Router
}

