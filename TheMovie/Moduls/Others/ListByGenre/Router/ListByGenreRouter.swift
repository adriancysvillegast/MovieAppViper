//
//  ListByGenreRouter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 17/9/23.
//

import Foundation
import UIKit

protocol ListByGenreRouting: AnyObject {
    func showList(idGenre: String, nameGenre: String, fromController: UIViewController)
}

class ListByGenreRouter: ListByGenreRouting {
    
    func showList(idGenre: String, nameGenre: String, fromController: UIViewController) {
        let interactor = ListByGenreInteractor()
        let presenter = ListByGenrePresenter(idGenre: idGenre,
                                             name: nameGenre,
                                             interactor: interactor)
        let view = ListByGenreView(presenter: presenter)
        presenter.view = view
        interactor.presenter = presenter
        fromController.navigationController?.pushViewController(view, animated: true)
    }
    
}
