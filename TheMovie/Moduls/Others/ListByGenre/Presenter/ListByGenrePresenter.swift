//
//  ListByGenrePresenter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 17/9/23.
//

import Foundation

// MARK: - ListByGenrePresentable
protocol ListByGenrePresentable: AnyObject {
    var view: ListByGenreViewDelegate? { get }
    
    func getList()
    func mappingList(model: ListByGenrerResponseEntity)
    func didFailure(message: String)
    
}

// MARK: - ListByGenrePresenter
class ListByGenrePresenter: ListByGenrePresentable {
    // MARK: - Properties
    weak var view: ListByGenreViewDelegate?
    let interactor: ListByGenreInteractable
    var idGenre: String
    var name: String
    private let mapper: Mapper
    // MARK: - Init
    
    init( idGenre: String,
          name: String,
          interactor: ListByGenreInteractable,
          mapper: Mapper = Mapper() ) {
        
        self.interactor = interactor
        self.idGenre = idGenre
        self.mapper = mapper
        self.name = name
    }
    
    func getList() {
        interactor.getList(idGenre: idGenre)
    }
    
    func mappingList(model: ListByGenrerResponseEntity) {
        let modelCell = mapper.mappingListByGenre(model: model)
        view?.updateView(model: modelCell, nameGenre: name)
    }
    
    func didFailure(message: String) {
        view?.didFailure(message: message)
    }
    
}
