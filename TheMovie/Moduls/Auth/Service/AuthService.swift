//
//  AuthService.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 12/9/23.
//

import Foundation

class AuthService {
    // MARK: - Properties
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"] ?? "https://api.themoviedb.org/3"
    
    // MARK: - Methods

    func getRequestToken(completion: @escaping (Result<RequestTokenEntity, Error>) -> Void ) {
        CoreService.shared.get(
            url: URL(string: baseURL + "/authentication/token/new"),
            expecting: RequestTokenEntity.self) { result in
                switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchGuestSection(completion: @escaping (Result<GuestSectionResponseEntity, Error>) -> Void) {
        CoreService.shared.get(
            url: URL(string: baseURL + "/authentication/guest_session/new"),
            expecting: GuestSectionResponseEntity.self) { result in
                switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
