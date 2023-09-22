//
//  HomeInteractor.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 20/9/23.
//

import Foundation
// MARK: - HomeInteractable
protocol HomeInteractable: AnyObject {
    var presenter: HomePresentable? { get }
    
    func fetchUpComingMovies()
    func fetchTopRateMovie()
    func fetchTopRateTV()
    func fetchSugActionMovie()
    func fetchSugDocumentaryMovie()
    func fetchSugAnimationMovie()
    func fetchSugComedyTV()
    func fetchSugDramaTV()
    func fetchSugMisteryTV()
    func fetchAll()
    
   
    
}


class HomeInteractor: HomeInteractable {

    

    
    
    // MARK: - Properties
    
    weak var presenter: HomePresentable?
    private let service: HomeService
    
    // MARK: - Init
    init(service: HomeService = HomeService()) {
        self.service = service
    }
    
    
    // MARK: - Methods
     
    func fetchUpComingMovies() {
        service.getUpComingMovie { result in
            switch result {
            case .success(let model):
                self.presenter?.mappingUpComingMovie(model: model)
            case .failure(let error):
                self.presenter?.didFailure(message: error.localizedDescription)
                
            }
        }
    }
    
    
    func fetchTopRateMovie() {
        service.getTopRateMovie { result in
            switch result {
            case .success(let model):
                self.presenter?.mappingTopRateMovie(model: model)
            case .failure(let error):
                self.presenter?.didFailure(message: error.localizedDescription)
                
            }
        }
    }
    
    func fetchTopRateTV() {
        service.fetchTopRateTV { result in
            switch result {
            case .success(let model):
                self.presenter?.mappingTopRateTV(model: model)
            case .failure(let error):
                self.presenter?.didFailure(message: error.localizedDescription)
                
            }
        }
    }
    
    func fetchSugActionMovie() {
        service.getSuggestionActionMovie { result in
            
            switch result {
            case .success(let model):
                self.presenter?.mappingSuggestionActionMovie(model: model)
            case .failure(let error):
                self.presenter?.didFailure(message: error.localizedDescription)
            }
            
        }
    }
    
    func fetchSugDocumentaryMovie() {
        service.getSuggestionDocumentaryMovie { result in
            switch result {
            case .success(let model):
                self.presenter?.mappingSuggestionDocumentaryMovie(model: model)
            case .failure(let error):
                self.presenter?.didFailure(message: error.localizedDescription)
                
            }
            
        }
    }
    
    
    func fetchSugAnimationMovie() {
        service.getSuggestionAnimationMovie { result in
            switch result {
            case .success(let model):
                self.presenter?.mappingSuggestionAnimationMovie(model: model)
            case .failure(let error):
                self.presenter?.didFailure(message: error.localizedDescription)
                
            }
            
        }
    }
    
    func fetchSugComedyTV() {
        service.getSuggestionComedyTV { result in
            
            switch result {
            case .success(let model):
                self.presenter?.mappingSuggestionComedyTV(model: model)
            case .failure(let error):
                self.presenter?.didFailure(message: error.localizedDescription)
            }
        }
    }
    
    func fetchSugDramaTV() {
        service.getSuggestionDramaTV { result in
            
            switch result {
            case .success(let model):
                self.presenter?.mappingSuggestionDramaTV(model: model)
            case .failure(let error):
                self.presenter?.didFailure(message: error.localizedDescription)
            }
            
        }
    }
    func fetchSugMisteryTV() {
        service.getSuggestionMysteryTV { result in
            
            switch result {
            case .success(let model):
                self.presenter?.mappingSuggestionMisteryTV(model: model)
            case .failure(let error):
                self.presenter?.didFailure(message: error.localizedDescription)
                
            }
        }
    }
    func fetchAll() {



//

//

//
//
    }
    


    

    
    
    
}
