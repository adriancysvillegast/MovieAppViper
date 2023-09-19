//
//  AuthRouter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 12/9/23.
//

import Foundation
import UIKit

protocol AuthRouting: AnyObject {
    func isSigned() -> Bool
    func showAuthView() -> UIViewController
}

class AuthRouter : AuthRouting {
    
    func isSigned() -> Bool {
        let interactor = AuthInteractor()
        let presenter = AuthPresenter(interactor: interactor, router: self)
        return presenter.isSigned()
    }
    
    func showAuthView() -> UIViewController {
        let interactor = AuthInteractor()
        let presenter = AuthPresenter(interactor: interactor, router: self)
        let view = AuthView(presenter: presenter)
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
}
