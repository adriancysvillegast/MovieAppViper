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
    
    func showTVModul() -> UIViewController
}

class TVRouter: TVRouting {
    // MARK: - Properties
    weak var tvView: TVView?
    
    // MARK: - Methods
    
    func showTVModul() -> UIViewController {
        let interactor = TVInteractor()
        let presenter = TVPresenter(interactor: interactor, router: self)
        let view = TVView(presenter: presenter)
        tvView = view
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
    
    
}
