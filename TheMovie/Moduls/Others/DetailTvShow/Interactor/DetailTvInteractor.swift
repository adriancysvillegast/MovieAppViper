//
//  DetailTvInteractor.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 14/9/23.
//

import Foundation

protocol DetailTvInteractable: AnyObject {
    var presenter: DetailTvPresentable? { get }
    func getDetailTV(idTV: String)
}

class DetailTvInteractor: DetailTvInteractable {
    
    // MARK: - Porperties
    private let service: DetailTvService
    weak var presenter: DetailTvPresentable?
    // MARK: - Init
    
    init(service: DetailTvService = DetailTvService()) {
        self.service = service
    }
    
    // MARK: - Methods
    
    func getDetailTV(idTV: String) {
        service.fetchDetailTvShow(withTvID: idTV) { result in
            switch result {
            case .success(let model):
                self.presenter?.mappingDetailTV(model: model)
            case .failure(let error):
                self.presenter?.didFailure(message: error.localizedDescription)
            }
        }
    }
}
