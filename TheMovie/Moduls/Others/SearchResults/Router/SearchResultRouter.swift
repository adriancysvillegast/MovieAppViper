//
//  SearchResultRouter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 16/9/23.
//

import Foundation
import UIKit


protocol SearchResultRouting: AnyObject {
    func showResult(query: String, fromViewController: UIViewController)
}
// MARK: - SearchResultRouter

class SearchResultRouter: SearchResultRouting {
    
    func showResult(query: String, fromViewController: UIViewController) {
        let interactor = SearchResultInteractor()
        let presenter = SearchResultPresenter(query: query, interactor: interactor)
        let view = SearchResultView(presenter: presenter)
        presenter.view = view
        interactor.presenter = presenter
        fromViewController.navigationController?.pushViewController(view, animated: true)
    }
    
    
}
