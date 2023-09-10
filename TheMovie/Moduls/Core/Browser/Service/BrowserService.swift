//
//  BrowserService.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 8/9/23.
//

import Foundation

class BrowserService {
    // MARK: - Properties
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"] ?? "https://api.themoviedb.org/3"
    private let apiToken = ProcessInfo.processInfo.environment["token"] ?? ""

    // MARK: - Methods
    
    func getUpComing(completion: @escaping (Result<UpComingResponseEntity, Error>) -> Void){
        CoreService.shared.get(
            url: URL(string: baseURL + "/movie/upcoming?api_key=" + apiToken),
            expecting: UpComingResponseEntity.self) { result in
                
                switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getTopMovies(completion: @escaping (Result<PopularMoviesResponseEntity, Error>) -> Void){
        CoreService.shared.get(
            url: URL(string: baseURL + "/movie/popular?api_key=" + apiToken),
            expecting: PopularMoviesResponseEntity.self) { result in
                
                switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getNowPlaying(completion: @escaping (Result<NowPlayingResponseEntity, Error>) -> Void){
        CoreService.shared.get(
            url: URL(string: baseURL + "/movie/now_playing?api_key=" + apiToken),
            expecting: NowPlayingResponseEntity.self) { result in
                
                switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
    func getTopRate(completion: @escaping (Result<TopRateResponseEntity, Error>) -> Void){
        CoreService.shared.get(
            url: URL(string: baseURL + "/movie/top_rated?api_key=" + apiToken),
            expecting: TopRateResponseEntity.self) { result in
                
                switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
    
    
}
