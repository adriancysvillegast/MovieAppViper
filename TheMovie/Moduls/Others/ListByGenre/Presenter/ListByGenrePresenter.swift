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
    func didTap(id: String)
    func didFailure(message: String)
    
}

// MARK: - ListByGenrePresenter
class ListByGenrePresenter: ListByGenrePresentable {
    // MARK: - Properties
    weak var view: ListByGenreViewDelegate?
    let interactor: ListByGenreInteractable
    var idGenre: String
    var name: String
    var type: TypeList
    private let mapper: Mapper
    private var router: ListByGenreRouting
    // MARK: - Init
    
    init(idGenre: String,
         name: String, type: TypeList,
          interactor: ListByGenreInteractable,
         mapper: Mapper = Mapper(), router: ListByGenreRouting ) {
        
        self.interactor = interactor
        self.idGenre = idGenre
        self.mapper = mapper
        self.name = name
        self.type = type
        self.router = router
    }
    
    func getList() {
        interactor.getList(idGenre: idGenre, type: type)
    }
    
    func mappingList(model: ListByGenrerResponseEntity) {
        if type == .movie {
            let modelCell = mapper.mappingListByGenre(model: model)
            view?.updateView(model: modelCell, nameGenre: name)
        } else {
            let modelCell = mapper.mappingListByGenre(model: model)
            view?.updateView(model: modelCell, nameGenre: name)
        }
       
    }
    
    func didFailure(message: String) {
        view?.didFailure(message: message)
    }
    
    func didTap(id: String) {
        if type == .movie{
            router.showDetailMovie(id: id)
        }else {
            router.showDetailTv(id: id)
        }
    }
}
