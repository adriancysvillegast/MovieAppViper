//
//  MovieRouter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 8/9/23.
//

import Foundation
import UIKit

protocol MovieRouting: AnyObject {
    var browserView : MovieView? { get }
    var detailView: DetailMovieRouting? { get }
    
    func showMovies() -> UIViewController
    func showDetailMovie(movieID: String)
}

class MovieRouter: MovieRouting {
    
    
    // MARK: - Properties
    var browserView : MovieView?
    var detailView: DetailMovieRouting?
    // MARK: - Methods
    public func showMovies() -> UIViewController {
        detailView = DetailMovieRouter()
        let interactor = MovieInteractor()
        let presenter = MoviePresenter(interactor: interactor, router: self)
        let view = MovieView(presenter: presenter)
        browserView = view
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
    
    func showDetailMovie(movieID: String) {
        guard let fromViewController = browserView else {
            return
        }
        
        detailView?.showDetail(fromViewController: fromViewController, withMovieID: movieID)
    }
}
