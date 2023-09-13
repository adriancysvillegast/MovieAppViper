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
    // MARK: - Methods
    func getRequestToken()
    
}

class AuthInteractor: AuthInteractable {
    
    // MARK: - Properties
    var presenter: AuthPresentable?
    
    private let service: AuthService
    
    var accessToken: String? {
        return UserDefaults.standard.string(forKey: "Token")
    }
    
    var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "RefreshToken")
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
    
    func getRequestToken() {
        self.service.getRequestToken { result in
            switch result {
            case .success(let token):
                print(token)
                self.saveToken(model: token)
            case .failure(let errorToken):
                print(errorToken)
            }
        }
    }
    
    func saveToken(model: RequestTokenEntity) {
        UserDefaults.standard.set(model.requestToken, forKey: "Token")
        // 2023-09-12 22:10:48 UTC Son 60 minutos exactos(3600 segundos)
        UserDefaults.standard.set(Date().addingTimeInterval(TimeInterval(3600)), forKey: "ExpireAt")
        UserDefaults.standard.set(model.success, forKey: "RefreshToken")
    }
    
    public func signOut(completion: (Bool) -> Void ) {
        UserDefaults.standard.set(nil, forKey: "Token")
        UserDefaults.standard.set(nil, forKey: "ExpireAt")
        UserDefaults.standard.set(nil, forKey: "RefreshToken")
        completion(true)
    }
    
    
    
}
