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
    var listGenreRouter: ListByGenreRouting? { get }
    
    func showSearch() -> UIViewController
    func showResults(query: String)
    func fetchListByGenre(idGenre: String, nameGenre: String, type: TypeList)
}

// MARK: - SearchRouter
class SearchRouter: SearchRouting {
    weak var searchView: SearchView?

    var searchResult: SearchResultRouting?
    var listGenreRouter: ListByGenreRouting?
    
    func showSearch() -> UIViewController {
        searchResult = SearchResultRouter()
        listGenreRouter = ListByGenreRouter()
        
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
    
    func fetchListByGenre(idGenre: String, nameGenre: String, type: TypeList) {
        guard let fromController = searchView else { return }
        //llamar al router
        listGenreRouter?.showList(idGenre: idGenre, nameGenre: nameGenre, fromController: fromController, type: type )
    }
    
 
    
}
