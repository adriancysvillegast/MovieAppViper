//
//  ListByGenreRouter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 17/9/23.
//

import Foundation
import UIKit

protocol ListByGenreRouting: AnyObject {
    var listView: ListByGenreView? { get }
    var detailMovie: DetailMovieRouting? { get }
    var detailTv: DetailTVRouting? { get }
    
    func showList(idGenre: String, nameGenre: String, fromController: UIViewController, type: TypeList)
    func showDetailTv(id: String)
    func showDetailMovie(id: String)
}

class ListByGenreRouter: ListByGenreRouting {
    var listView: ListByGenreView?
    var detailMovie: DetailMovieRouting?
    var detailTv: DetailTVRouting?
    
    func showList(idGenre: String, nameGenre: String, fromController: UIViewController, type: TypeList) {
        detailTv = DetailTVRouter()
        detailMovie = DetailMovieRouter()
        
        let interactor = ListByGenreInteractor()
        let presenter = ListByGenrePresenter(
            idGenre: idGenre,
            name: nameGenre,
            type: type,
            interactor: interactor,
            router: self)
        let view = ListByGenreView(presenter: presenter)
        listView = view
        presenter.view = view
        interactor.presenter = presenter
        fromController.navigationController?.pushViewController(view, animated: true)
    }
    
    func showDetailTv(id: String) {
        guard let fromViewController = listView else { return }
        detailTv?.showDetailTV(idTV: id, fromViewCuntroller: fromViewController)
    }
    
    func showDetailMovie(id: String) {
        guard let fromViewController = listView else { return }
        detailMovie?.showDetail(fromViewController: fromViewController, withMovieID: id)
    }
}
