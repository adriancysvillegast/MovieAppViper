//
//  SearchResultRouter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 16/9/23.
//

import Foundation
import UIKit


protocol SearchResultRouting: AnyObject {
    var viewSearcResult: SearchResultView? { get }
    var detailTv: DetailTVRouting? { get }
    var detailMovie: DetailMovieRouting? { get }
    
    func showResult(query: String, fromViewController: UIViewController)
    func showDetailTv(idTv: String )
    func showDetailMovie(idMovie: String)
}
// MARK: - SearchResultRouter

class SearchResultRouter: SearchResultRouting {
    // MARK: - Properties
    var viewSearcResult: SearchResultView?
    
    var detailTv: DetailTVRouting?
    var detailMovie: DetailMovieRouting?
    
    // MARK: - Methods
    
    func showResult(query: String, fromViewController: UIViewController) {
        detailTv = DetailTVRouter()
        detailMovie = DetailMovieRouter()
        
        let interactor = SearchResultInteractor()
        let presenter = SearchResultPresenter(query: query, interactor: interactor, router: self)
        let view = SearchResultView(presenter: presenter)
        viewSearcResult = view
        presenter.view = view
        interactor.presenter = presenter
        fromViewController.navigationController?.pushViewController(view, animated: true)
    }
    
    func showDetailTv(idTv: String ) {
        guard let fromViewController = viewSearcResult else { return }
        detailTv?.showDetailTV(idTV: idTv, fromViewCuntroller: fromViewController)
    }
    
    func showDetailMovie(idMovie: String) {
        guard let fromViewController = viewSearcResult else { return }
        detailMovie?.showDetail(fromViewController: fromViewController, withMovieID: idMovie)
    }
    
}
