//
//  HomeRouter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 20/9/23.
//

import Foundation
import UIKit


protocol HomeRouting: AnyObject {
    
    var viewHome: HomeView? { get }
    var detailMovie: DetailMovieRouting? { get }
    var detailTv: DetailTVRouting? { get }
    
    func showHome() -> UIViewController
    func showDetailMovie(id: String)
    func showDetailTv(id: String)
}

class HomeRouter: HomeRouting {
    
    weak var viewHome: HomeView?
    var detailMovie: DetailMovieRouting?
    var detailTv: DetailTVRouting?
    
    func showHome() -> UIViewController {
        detailTv = DetailTVRouter()
        detailMovie = DetailMovieRouter()
        
        let interactor = HomeInteractor()
        let presenter = HomePresenter(interactor: interactor, router: self)
        let view = HomeView(presenter: presenter)
        viewHome = view
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
    
    func showDetailMovie(id: String) {
        guard let fromController = viewHome else {
            return
        }
        detailMovie?.showDetail(fromViewController: fromController, withMovieID: id)
    }
    
    func showDetailTv(id: String) {
        guard let fromController = viewHome else {
            return
        }
        detailTv?.showDetailTV(idTV: id, fromViewCuntroller: fromController)
    }
    
}
