//
//  DetailTVRouter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 14/9/23.
//

import Foundation
import UIKit

// MARK: - DetailTVRouting
protocol DetailTVRouting: AnyObject {
    func showDetailTV(idTV: String, fromViewCuntroller: UIViewController)
}

// MARK: - DetailTVRouter

class DetailTVRouter: DetailTVRouting  {
    // MARK: - Methods
    
    func showDetailTV(idTV: String, fromViewCuntroller: UIViewController){

        let interector = DetailTvInteractor()
        let presenter = DetailTvPresenter(idTV: idTV, interactor: interector)
        let view = DetailTvView(presenter: presenter)
        
        presenter.view = view
        interector.presenter = presenter
        fromViewCuntroller.navigationController?.pushViewController(view, animated: true)
    }
}
