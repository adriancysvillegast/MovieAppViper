//
//  DetailMovieInteractor.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 10/9/23.
//

import Foundation

protocol DetailMovieInteractable: AnyObject {
//    Properties
    var presenter: DetailMoviePresentable? { get }
//    Methods
    func fetchDetailMovie(with movieId: String)
}

class DetailMovieInteractor: DetailMovieInteractable {
    // MARK: - Properties
    weak var presenter: DetailMoviePresentable?
    
    private let service: DetailService
    
    // MARK: -  Init
    
    init(service: DetailService = DetailService()) {
        self.service = service
    }
    
    // MARK: - Methods
    
    func fetchDetailMovie(with movieId: String) {
        service.getDetail(withMovieID: movieId) { result in
            switch result {
            case .success(let model):
                self.presenter?.didSuccessDetail(model: model)
            case .failure(let error):
                print(error)
                self.presenter?.didFailureDetail(message: error.localizedDescription)
            }
        }
    }
    
    
}
