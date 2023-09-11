//
//  DetailService.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 10/9/23.
//

import Foundation

class DetailService {
    // MARK: - Properties
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"] ?? "https://api.themoviedb.org/3"
    private let apiToken = ProcessInfo.processInfo.environment["token"] ?? ""

    // MARK: - Methods
    
    func getDetail(withMovieID movieID: String,
                   completion: @escaping (Result<DetailMovieResponseEntity, Error>) -> Void ) {
        CoreService.shared.get(
            url: URL(string: baseURL + "/movie/\(movieID)?api_key=" + apiToken ),
            expecting: DetailMovieResponseEntity.self) { result in
                switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        
    }
}
