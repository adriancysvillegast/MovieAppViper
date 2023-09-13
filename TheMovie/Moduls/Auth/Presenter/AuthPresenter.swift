//
//  AuthPresenter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 12/9/23.
//

import Foundation

protocol AuthPresentable: AnyObject {
    // MARK: - Properties
    var view: AuthViewDelegate? { get }
    
    // MARK: - Methods
    func getToken()
}

class AuthPresenter: AuthPresentable {
    
    // MARK: - Properties
    var view: AuthViewDelegate?
    
    private var interactor: AuthInteractable?
    private let router: AuthRouting

    // MARK: - init
    init(interactor: AuthInteractable, router: AuthRouting) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Methods

    func getToken() {
        interactor?.getRequestToken()
    }
}
