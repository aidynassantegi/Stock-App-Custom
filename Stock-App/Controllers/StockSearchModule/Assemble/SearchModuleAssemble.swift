//
//  SearchModuleAssemble.swift
//  Stock-App
//
//  Created by Aidyn Assan on 01.08.2022.
//

import Foundation

final class SearchModuleAssemble {
    func assemble() ->  SearchViewController {
        let apiManager = APIManager()
        
        let presenter = SearchPresenter()
        let interactor = SearchInteractor(requestManager: apiManager)
        
        let view = SearchViewController()
        let searchManager = SearchManager()
        view.output = presenter
        view.searchManager = searchManager
        
        presenter.interactor = interactor
        presenter.view = view
        
        interactor.output = presenter
        
        
        return view
    }
}
