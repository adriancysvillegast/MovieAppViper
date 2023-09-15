//
//  DetailTvService.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 14/9/23.
//

import Foundation

class DetailTvService {
    // MARK: - Properties
    
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"] ?? "https://api.themoviedb.org/3"
    private let apiToken = ProcessInfo.processInfo.environment["token"] ?? ""

    // MARK: - Methods
    
    func fetchDetailTvShow(
        withTvID tvID: String,
        completion: @escaping (Result<DetailTvResponseEntity, Error>) -> Void){
            CoreService.shared.get(
                url: URL(string: baseURL + "/tv/\(tvID)?api_key=" + apiToken),
                expecting: DetailTvResponseEntity.self) { result in
                    switch result {
                    case .success(let model):
                        print(model)
                        completion(.success(model))
                    case .failure(let error):
                        print(error)
                        completion(.failure(error))
                    }
                }
    }
}
