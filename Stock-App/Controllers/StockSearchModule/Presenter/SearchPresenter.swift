//
//  SearchPresenter.swift
//  Stock-App
//
//  Created by Aidyn Assan on 01.08.2022.
//

import Foundation

final class SearchPresenter: SearchViewOutput {
    
    // MARK: - Interactor
    var interactor: SearchInteractor?
    func searchFor(query: String) {
        interactor?.searchStock(with: query)
    }
    
    weak var view: SearchViewInput?
    func setSearchResults(with stocks: [TableViewModel]) {
        view?.setSearcResults(with: stocks)
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

