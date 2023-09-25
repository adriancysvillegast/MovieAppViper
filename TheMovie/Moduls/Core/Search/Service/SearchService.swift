//
//  SearchService.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 15/9/23.
//

import Foundation

class SearchService {
    
    // MARK: - Properties
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"] ?? "https://api.themoviedb.org/3"
    private let apiToken = ProcessInfo.processInfo.environment["token"] ?? ""

    // MARK: - Methods
    func getGenreMovies(
        completion: @escaping (Result<ResultGenreResponseEntity, Error>) -> Void ) {
            CoreService.shared.get(
                url: URL(string: baseURL + "/genre/movie/list?api_key=" + apiToken),
                expecting: ResultGenreResponseEntity.self) { result in
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    
    func getGenreTV(
        completion: @escaping (Result<ResultGenreResponseEntity, Error>) -> Void ) {
            CoreService.shared.get(
                url: URL(string: baseURL + "/genre/tv/list?api_key=" + apiToken),
                expecting: ResultGenreResponseEntity.self) { result in
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    

}
