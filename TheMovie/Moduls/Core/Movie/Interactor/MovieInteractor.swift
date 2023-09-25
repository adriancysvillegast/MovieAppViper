//
//  BrowserInteractor.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 8/9/23.
//

import Foundation

// MARK: - MovieInteractable
protocol MovieInteractable: AnyObject {
    // MARK: - Properties
    var presenter: MoviePresentable? { get }
    // MARK: - Methods
    func getPopularMovies()
    func getNowPlaying()
    func getTopRate()
    func getUpComing()
}

// MARK: - MovieInteractor
class MovieInteractor: MovieInteractable {

    // MARK: - Properties
    weak var presenter: MoviePresentable?
    private let service: MovieService
    
    init(service: MovieService = MovieService()) {
        self.service = service
    }
    
    // MARK: - Methods
   
    func getUpComing() {
        service.getUpComing { result in
            switch result {
            case .success(let model):
                self.presenter?.didSuccessUpComing(model: model)
            case .failure(let error):
                self.presenter?.didFailure(message: error.localizedDescription)
            }
        }
    }

    func getPopularMovies() {
        service.getTopMovies { result in
            switch result {
            case .success(let model):
                self.presenter?.didSuccessPopularMovie(model: model)
            case .failure(let error):
                self.presenter?.didFailure(message: error.localizedDescription)
            }
        }
    }
    
    func getNowPlaying() {
        service.getNowPlaying { result in
            switch result {
            case .success(let model):
                self.presenter?.didSuccessNowPlaying(model: model)
            case .failure(let error):
                self.presenter?.didFailure(message: error.localizedDescription)
            }
        }
    }
    
    func getTopRate() {
        service.getTopRate { result in
            switch result {
            case .success(let model):
                self.presenter?.didSuccessTopRate(model: model)
            case .failure(let error):
                self.presenter?.didFailure(message: error.localizedDescription)
            }
        }
    }
    
    
}
