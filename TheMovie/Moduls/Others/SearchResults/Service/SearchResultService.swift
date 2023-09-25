//
//  SearchResultService.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 16/9/23.
//

import Foundation

class SearchResultService {
    // MARK: - Properties
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"] ?? "https://api.themoviedb.org/3"
    private let apiToken = ProcessInfo.processInfo.environment["token"] ?? ""

    
    // MARK: - Methods
    
    func getSearchTv(
        query: String,
        completion: @escaping (Result<SearchResponseEntity, Error>) -> Void ) {
            CoreService.shared.get(
                url: URL(string: baseURL + "/search/tv?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&api_key=" + apiToken),
                expecting: SearchResponseEntity.self) { result in
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    
    func getSearchMovie(
        query: String,
        completion: @escaping (Result<SearchResponseEntity, Error>) -> Void ) {
            CoreService.shared.get(
                url: URL(string: baseURL + "/search/movie?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&api_key=" + apiToken),
                expecting: SearchResponseEntity.self) { result in
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
}
