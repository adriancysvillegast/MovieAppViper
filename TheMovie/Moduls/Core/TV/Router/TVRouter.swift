//
//  TVRouter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 13/9/23.
//

import Foundation
import UIKit

protocol TVRouting: AnyObject {
    var tvView: TVView? { get }
    var detailTV: DetailTVRouting? { get }
    
    func showTVModul() -> UIViewController
    func showDetailTV(idTV: String)
}

class TVRouter: TVRouting {
    // MARK: - Properties
    weak var tvView: TVView?
    var detailTV: DetailTVRouting?
    
    // MARK: - Methods
    
    func showTVModul() -> UIViewController {
        detailTV = DetailTVRouter()

        let interactor = TVInteractor()
        let presenter = TVPresenter(interactor: interactor, router: self)
        let view = TVView(presenter: presenter)
        tvView = view
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
    
    func showDetailTV(idTV: String) {
        guard let fromController = tvView else { return }
        detailTV?.showDetailTV(idTV: idTV, fromViewCuntroller: fromController)
    }
    
    
}
