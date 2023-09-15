//
//  TVPresenter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 13/9/23.
//

import Foundation

enum TVShowType {
    case airToday(model: [TvAiringTodayViewModelCell])
    case onAir(model: [TvOnAirViewModelCell])
    case popular(model: [TvPopularViewModelCell])
    case topRate(model: [TvTopRateViewModelCell])
    
    var title: String {
        switch self {
        case .airToday:
            return "Air Today"
        case .onAir:
            return "On Air"
        case .popular:
            return "Popular"
        case .topRate:
            return "Top Rate"
        }
    }
}

protocol TVPresentable: AnyObject {
    // MARK: - Properties
    var view: TVViewDelegate? { get }
    
    // MARK: - Methods
    func fetchTvShows()
    func mappingTvAir(model: TVAiringTodayResponsesEntity)
    func mappingTvOnAir(model: TVOnAirResponseEntity)
    func mappingTvPopular(model: TVPopularResponseEntity)
    func mappingTvTopRate(model: TVTopRateResponseEntity)
    func didTapTv(id: String)
    func didFailured(message: String)
}

class TVPresenter: TVPresentable {
    // MARK: - Properties
    weak var view: TVViewDelegate?
    private var interactor: TVInteractable
    var mapper: Mapper
    private let router: TVRouting
    var dataTv: [TVShowType] = []
    // MARK: - Init
    
    init(interactor: TVInteractable, router: TVRouting, mapper: Mapper = Mapper()) {
        self.interactor = interactor
        self.router = router
        self.mapper = mapper
    }

    // MARK: - Methods
    func fetchTvShows() {
//        Call all endPoints
        interactor.getTvAirToday()
        interactor.getTvOnAir()
        interactor.getTvPopular()
        interactor.getTvTopRate()
    }
    
    func mappingTvAir(model: TVAiringTodayResponsesEntity) {
        let modelCell = mapper.tvAiring(model: model)
        dataTv.append(.airToday(model: modelCell))
    }
    
    func mappingTvOnAir(model: TVOnAirResponseEntity) {
        let modelCell = mapper.tvOnAir(model: model)
        dataTv.append(.onAir(model: modelCell))
    }
    
    func mappingTvPopular(model: TVPopularResponseEntity) {
        let modelCell =  mapper.tvPopular(model: model)
        dataTv.append(.popular(model: modelCell))
        
    }
    
    func mappingTvTopRate(model: TVTopRateResponseEntity) {
        let modelCell = mapper.tvTopRate(model: model)
        dataTv.append(.topRate(model: modelCell))
        view?.showTvShows(model: dataTv)
    }
    
    func didTapTv(id: String) {
        router.showDetailTV(idTV: id)
    }
    
    func didFailured(message: String) {
        view?.showError(message: message)
    }
}
