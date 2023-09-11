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
    
    func showBrowser(window: UIWindow?)
    func showDetailMovie(movieID: String)
}

class BrowserRouter: BrowserRouting {
    // MARK: - Properties
    var browserView : BrowserView?
    var detailView: DetailMovieRouting?
    // MARK: - Methods
    
    func showBrowser(window: UIWindow?) {
        detailView = DetailMovieRouter()
        let interactor = BrowserInteractor()
        let presenter = BrowserPresenter(interactor: interactor, router: self)
        
        browserView = BrowserView(presenter: presenter)
        presenter.view = browserView
        interactor.presenter = presenter
        let view = UINavigationController(rootViewController: browserView!)
        window?.rootViewController = view
        window?.makeKeyAndVisible()
    }
    
    func showDetailMovie(movieID: String) {
        guard let fromViewController = browserView else {
            return
        }
        
        detailView?.showDetail(fromViewController: fromViewController, withMovieID: movieID)
    }
}
