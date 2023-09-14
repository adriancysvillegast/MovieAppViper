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
    func getTvOnAir()
    func getTvPopular()
    func getTvTopRate()
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
                self.presenter?.didFailured(message: error.localizedDescription)
            }
        }
    }
    
    func getTvOnAir() {
        service.fetchTVOnAir { result in
            switch result {
            case .success(let model):
                self.presenter?.mappingTvOnAir(model: model)
            case .failure(let error):
                self.presenter?.didFailured(message: error.localizedDescription)
            }
        }
    }
    
    func getTvPopular() {
        service.fetchTVPopular { result in
            switch result {
            case .success(let model):
                self.presenter?.mappingTvPopular(model: model)
            case .failure(let error):
                self.presenter?.didFailured(message: error.localizedDescription)
            }
        }
    }
    
    func getTvTopRate() {
        service.fetchTVTopRate { result in
            switch result {
            case .success(let model):
                self.presenter?.mappingTvTopRate(model: model)
            case .failure(let error):
                self.presenter?.didFailured(message: error.localizedDescription)
            }
        }
    }
    
}
