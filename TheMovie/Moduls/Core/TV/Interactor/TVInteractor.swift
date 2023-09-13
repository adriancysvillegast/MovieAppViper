//
//  TVInteractor.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 13/9/23.
//

import Foundation

protocol TVInteractable: AnyObject {
    // MARK: - Properties
    var presenter: TVPresentable? { get }
    // MARK: - Methods
    func getTvAirToday()
}

class TVInteractor: TVInteractable {
    // MARK: - Properties
    weak var presenter: TVPresentable?
    private let service: TVService
    
    init(service: TVService = TVService() ) {
        self.service = service
    }
    
    // MARK: - Methods
    func getTvAirToday() {
        service.fetchTVAirToday { result in
            switch result {
            case .success(let model):
                self.presenter?.mappingTvAir(model: model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
