//
//  SearchRouter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 15/9/23.
//

import Foundation
import UIKit

// MARK: - Description
protocol SearchRouting: AnyObject {
    var searchView: SearchView? { get }
    var searchResult: SearchResultRouting? { get }
    
    func showSearch() -> UIViewController
    func showResults(query: String)
}

// MARK: - SearchRouter
class SearchRouter: SearchRouting {
    weak var searchView: SearchView?

    var searchResult: SearchResultRouting?

    
    func showSearch() -> UIViewController {
        searchResult = SearchResultRouter()
        
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(interactor: interactor, router: self)
        let view = SearchView(presenter: presenter)
        searchView = view
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
    
    func showResults(query: String) {
        guard let fromController = searchView else { return }
        //llamar al router
        searchResult?.showResult(query: query, fromViewController: fromController)
    }
    
}
