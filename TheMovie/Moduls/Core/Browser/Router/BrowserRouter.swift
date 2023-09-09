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
    
    func showBrowser(window: UIWindow?)
}

class BrowserRouter: BrowserRouting {
    // MARK: - Properties
    var browserView : BrowserView?
    // MARK: - Methods
    
    func showBrowser(window: UIWindow?) {
        let interactor = BrowserInteractor()
        let presenter = BrowserPresenter(interactor: interactor, router: self)
        
        browserView = BrowserView(presenter: presenter)
        presenter.view = browserView
        interactor.presenter = presenter
        window?.rootViewController = browserView
        window?.makeKeyAndVisible()
    }
}
