//
//  DetailMovieRouter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 10/9/23.
//

import Foundation
import UIKit
// MARK: - DetailMovieRouting

protocol DetailMovieRouting: AnyObject {
    func showDetail(fromViewController: UIViewController,
                    withMovieID movieID: String)
}

// MARK: - DetailMovieRouter
class DetailMovieRouter: DetailMovieRouting{
    
    func showDetail(fromViewController: UIViewController, withMovieID movieID: String) {
        
        let interactor = DetailMovieInteractor()
        let presenter = DetailMoviePresenter(movieID: movieID, interactor: interactor)
        let view = DetailMovieView(presenter: presenter)
        
        presenter.view = view
        interactor.presenter = presenter
        fromViewController.navigationController?.pushViewController(view, animated: true)
    }
    
    
}
