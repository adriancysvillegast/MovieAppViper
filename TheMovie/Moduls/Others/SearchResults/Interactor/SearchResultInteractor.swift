//
//  SearchResultInteractor.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 16/9/23.
//

import Foundation

protocol SearchResultInteractable: AnyObject {
    var presenter: SearchResultPresentable? { get }
    func fetchSearch(query: String)
}

class SearchResultInteractor : SearchResultInteractable {
    weak var presenter: SearchResultPresentable?
    
    private let service: SearchResultService
    
    init(service: SearchResultService = SearchResultService()) {
        self.service = service
    }
    
    
    func fetchSearch(query: String) {
        
        service.getSearchTv(query: query) { result in
            switch result {
            case .success(let model):
                self.presenter?.mappingSearchTv(model: model)
            case .failure(let error):
                self.presenter?.didFailure(message: error.localizedDescription)
            }
        }
        
        service.getSearchMovie(query: query) { result in
            switch result {
            case .success(let model):
                self.presenter?.mappingSearchMovie(model: model)
            case .failure(let error):
                self.presenter?.didFailure(message: error.localizedDescription)
            }
        }
    }
}
