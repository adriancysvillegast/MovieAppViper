//
//  ListByGenreInteractor.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 17/9/23.
//

import Foundation

// MARK: - ListByGenreInteractable
protocol ListByGenreInteractable: AnyObject {
    var presenter: ListByGenrePresentable? { get }
    
    func getList(idGenre: String)
}

// MARK: - ListByGenreInteractor
class ListByGenreInteractor: ListByGenreInteractable {
    // MARK: - Properties
    
    var presenter: ListByGenrePresentable?
    private let service: ListByGenreService
    
    // MARK: - Init
    init(service: ListByGenreService = ListByGenreService() ){
        self.service = service
    }
    
    func getList(idGenre: String) {
        service.getListByGenre(
            idGenre: idGenre) { result in
                switch result {
                case .success(let model):
                    self.presenter?.mappingList(model: model)
                case .failure(let error):
                    self.presenter?.didFailure(message: error.localizedDescription)
                }
            }
    }
    
    
}
