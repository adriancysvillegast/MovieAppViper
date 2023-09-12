//
//  BrowserRouter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 8/9/23.
//

import Foundation
import UIKit

protocol BrowserRouting: AnyObject {
    var browserView : BrowserView? { get }
    var detailView: DetailMovieRouting? { get }
    
    func showBrowser() -> UIViewController
    func showDetailMovie(movieID: String)
}

class BrowserRouter: BrowserRouting {
    
    
    // MARK: - Properties
    var browserView : BrowserView?
    var detailView: DetailMovieRouting?
    // MARK: - Methods
    public func showBrowser() -> UIViewController {
        detailView = DetailMovieRouter()
        let interactor = BrowserInteractor()
        let presenter = BrowserPresenter(interactor: interactor, router: self)
        let view = BrowserView(presenter: presenter)
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
