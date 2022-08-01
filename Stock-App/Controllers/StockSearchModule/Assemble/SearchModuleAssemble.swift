//
//  SearchModuleAssemble.swift
//  Stock-App
//
//  Created by Aidyn Assan on 01.08.2022.
//

import Foundation

final class SearchModuleAssemble {
    func assemble() ->  SearchVC {
        let apiManager = APIManager()
        
        let presenter = SearchPresenter()
        let interactor = SearchInteractor(requestManager: apiManager)
        
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        let searchVC = SearchVC()
        let searchedCollectionVC = SearchedColectionVC()
        let searchVCManager = SearchVCManager()
        let searchResultVC = SearchResultVC()
        
        searchVC.searchResultVC = searchResultVC
        searchVC.searchedColectionVC = searchedCollectionVC
        searchVC.searchManager = searchVCManager
        
        searchVCManager.presenter = presenter
        
        presenter.searchResult = searchResultVC
        presenter.searchedColectionVC = searchedCollectionVC
        
        return searchVC
    }
}
