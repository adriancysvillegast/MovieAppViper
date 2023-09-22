//
//  HomeService.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 20/9/23.
//

import Foundation

class HomeService {
    
    // MARK: - Movies
    
    func getUpComingMovie(completion: @escaping (Result<UpComingResponseEntity, Error>) -> Void){
        CoreService.shared.get(
            url: URL(string: Constants.baseURL + "/movie/upcoming?api_key=" + Constants.apiToken),
            expecting: UpComingResponseEntity.self) { result in
                
                switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
    func getTopRateMovie(completion: @escaping (Result<TopRateResponseEntity, Error>) -> Void){
        CoreService.shared.get(
            url: URL(string: Constants.baseURL + "/movie/top_rated?api_key=" + Constants.apiToken),
            expecting: TopRateResponseEntity.self) { result in
                
                switch result {
                case .success(let model):
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
    // MARK: - TV
    
    func fetchTopRateTV(
        completion: @escaping (Result<TVTopRateResponseEntity, Error>) -> Void) {
            CoreService.shared.get(
                url: URL(string: Constants.baseURL + "/tv/top_rated?api_key=" + Constants.apiToken),
                expecting: TVTopRateResponseEntity.self) { result in
                    
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    
    // MARK: - Genres
    
    func getSuggestionActionMovie(completion: @escaping (Result<ListByGenrerResponseEntity, Error>) -> Void ) {
            //28 = action
        CoreService.shared.get(
                url: URL(string: Constants.baseURL + "/discover/movie?api_key=" + Constants.apiToken  + "&with_genres=28"),
                expecting: ListByGenrerResponseEntity.self) { result in
                    
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    
    func getSuggestionAnimationMovie(completion: @escaping (Result<ListByGenrerResponseEntity, Error>) -> Void ) {
        //16 = animation
        CoreService.shared.get(
                url: URL(string: Constants.baseURL + "/discover/movie?api_key=" + Constants.apiToken  + "&with_genres=16"),
                expecting: ListByGenrerResponseEntity.self) { result in
                    
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }//16
    }
    
    
    func getSuggestionDocumentaryMovie(completion: @escaping (Result<ListByGenrerResponseEntity, Error>) -> Void ) {
            //99 = Documentary
        CoreService.shared.get(
                url: URL(string: Constants.baseURL + "/discover/movie?api_key=" + Constants.apiToken  + "&with_genres=99"),
                expecting: ListByGenrerResponseEntity.self) { result in
                    
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        print(error)
                        completion(.failure(error))
                    }
                }
    }
    
    
    
    func getSuggestionComedyTV(
        completion: @escaping (Result<ListByGenrerResponseEntity, Error>) -> Void ) {
            //35 = Comedy
            CoreService.shared.get(
                url: URL(string: Constants.baseURL + "/discover/tv?api_key=" + Constants.apiToken  + "&with_genres=35"),
                expecting: ListByGenrerResponseEntity.self) { result in
                    
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    
    func getSuggestionMysteryTV(
        completion: @escaping (Result<ListByGenrerResponseEntity, Error>) -> Void ) {
            //9648 = Mystery
            CoreService.shared.get(
                url: URL(string: Constants.baseURL + "/discover/tv?api_key=" + Constants.apiToken  + "&with_genres=9648"),
                expecting: ListByGenrerResponseEntity.self) { result in
                    
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
    }
    
    func getSuggestionDramaTV(
        completion: @escaping (Result<ListByGenrerResponseEntity, Error>) -> Void ) {
            //18 = Drama
            CoreService.shared.get(
                url: URL(string: Constants.baseURL + "/discover/tv?api_key=" + Constants.apiToken  + "&with_genres=18"),
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
