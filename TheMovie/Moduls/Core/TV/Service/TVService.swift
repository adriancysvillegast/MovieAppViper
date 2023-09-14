//
//  TVService.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 13/9/23.
//

import Foundation

class TVService {
    // MARK: - Properties
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"] ?? "https://api.themoviedb.org/3"
    private let apiToken = ProcessInfo.processInfo.environment["token"] ?? ""

    
    // MARK: - Methods
    
    func fetchTVAirToday(
        completion: @escaping (Result<TVAiringTodayResponsesEntity, Error>) -> Void) {
            CoreService.shared.get(
                url: URL(string: baseURL + "/tv/airing_today?api_key=" + apiToken),
                expecting: TVAiringTodayResponsesEntity.self) { result in
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    
    func fetchTVOnAir(
        completion: @escaping (Result<TVOnAirResponseEntity, Error>) -> Void) {
            CoreService.shared.get(
                url: URL(string: baseURL + "/tv/on_the_air?api_key=" + apiToken),
                expecting: TVOnAirResponseEntity.self) { result in
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    
    func fetchTVPopular(
        completion: @escaping (Result<TVPopularResponseEntity, Error>) -> Void) {
            CoreService.shared.get(
                url: URL(string: baseURL + "/tv/popular?api_key=" + apiToken),
                expecting: TVPopularResponseEntity.self) { result in
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    
    func fetchTVTopRate(
        completion: @escaping (Result<TVTopRateResponseEntity, Error>) -> Void) {
            CoreService.shared.get(
                url: URL(string: baseURL + "/tv/top_rated?api_key=" + apiToken),
                expecting: TVTopRateResponseEntity.self) { result in
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
}
