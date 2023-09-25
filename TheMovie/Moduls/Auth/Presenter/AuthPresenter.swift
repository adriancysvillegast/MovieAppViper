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
    func getGuestSection()
    func getGuestSection(model: GuestSectionResponseEntity)
    func didFailure(messega: String)
    func isSigned() -> Bool
}

class AuthPresenter: AuthPresentable {
    
    // MARK: - Properties
    weak var view: AuthViewDelegate?
    private var interactor: AuthInteractable?
    private let router: AuthRouting

    
    // MARK: - init
    init(interactor: AuthInteractable, router: AuthRouting) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Methods

    func getGuestSection() {
        interactor?.fetchGuestSection()
    }
    
    func getGuestSection(model: GuestSectionResponseEntity) {
        if model.success {
            view?.successGuestSection(message: "Guest sessions are a special kind of session that give you some of the functionality of an account, but not all. \nFor example, some of the things you can do with a guest session are; maintain a rated list, a watchlist and a favourite list.\n Guest sessions will automatically be deleted if they are not used within 60 minutes of it being issued.")
        }else {
            view?.didFailured(message: "Sorry we couldn't create a guest section")
        }
        
    }

    func isSigned() -> Bool {
        guard let success = interactor?.refreshGuest else {
            return false
        }
        return success
    }
    
    func didFailure(messega: String) {
        view?.didFailured(message: messega)
    }

}
