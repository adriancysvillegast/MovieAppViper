//
//  ListByGenreService.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 17/9/23.
//

import Foundation

class ListByGenreService {
    
    // MARK: - Properties
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"] ?? "https://api.themoviedb.org/3"
    private let apiToken = ProcessInfo.processInfo.environment["token"] ?? ""

    
    // MARK: - Methods
    
    func getListByGenreMovie(
        idGenre: String,
        completion: @escaping (Result<ListByGenrerResponseEntity, Error>) -> Void ) {
            CoreService.shared.get(
                url: URL(string: baseURL + "/discover/movie?api_key=" + apiToken  + "&with_genres=\(idGenre)"),
                expecting: ListByGenrerResponseEntity.self) { result in
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    
    func getListByGenreTV(
        idGenre: String,
        completion: @escaping (Result<ListByGenrerResponseEntity, Error>) -> Void ) {
            CoreService.shared.get(
                url: URL(string: baseURL + "/discover/tv?api_key=" + apiToken  + "&with_genres=\(idGenre)"),
                expecting: ListByGenrerResponseEntity.self) { result in
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    
}
