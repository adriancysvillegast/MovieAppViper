//
//  AuthInteractor.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 12/9/23.
//

import Foundation

protocol AuthInteractable: AnyObject {
    // MARK: - Properties
    var presenter: AuthPresentable? { get }
    var guestSection: String? { get }
    var tokenExpirationDate: Date? { get }
    var refreshGuest: Bool? { get }
    // MARK: - Methods
    func fetchGuestSection()
}

class AuthInteractor: AuthInteractable {
    
    // MARK: - Properties
    weak var presenter: AuthPresentable?
    
    private let service: AuthService
    
    var guestSection: String? {
        return UserDefaults.standard.string(forKey: "guestSection")
    }
    
    var refreshGuest: Bool? {
        return UserDefaults.standard.object(forKey: "refreshGuest") as? Bool
    }
    
    var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "ExpireAt") as? Date
    }
    
    var shouldResfrestToken: Bool {
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    // MARK: - Init
    
    init(service: AuthService = AuthService()) {
        self.service = service
    }
    
    // MARK: - Methods
    func fetchGuestSection() {
        service.fetchGuestSection { result in
            switch result {
            case .success(let model):
                self.presenter?.getGuestSection(model: model)
                self.saveGuestSection(model: model)
            case .failure(let error):
                self.presenter?.didFailure(messega: error.localizedDescription)
                print(error)
            }
        }
    }
    
    
    // MARK: - Saving Methods

    func saveGuestSection(model: GuestSectionResponseEntity) {
        UserDefaults.standard.set(model.guestSessionId, forKey: "guestSection")
        //Son 60 minutos exactos(3600 segundos)
        UserDefaults.standard.set(Date().addingTimeInterval(TimeInterval(3600)), forKey: "ExpireAt")
        UserDefaults.standard.set(model.success, forKey: "refreshGuest")
    }
    
    public func signOut(completion: (Bool) -> Void ) {
        UserDefaults.standard.set(nil, forKey: "Token")
        UserDefaults.standard.set(nil, forKey: "ExpireAt")
        UserDefaults.standard.set(nil, forKey: "RefreshToken")
        completion(true)
    }
  
}
