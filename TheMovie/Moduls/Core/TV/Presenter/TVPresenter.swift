//
//  TVPresenter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 13/9/23.
//

import Foundation

enum TVShowType {
    case airToday(model: [TvAiringTodayViewModelCell])
    
    var title: String {
        switch self {
        case .airToday:
            return "Air Today"
        }
    }
}

protocol TVPresentable: AnyObject {
    // MARK: - Properties
    var view: TVViewDelegate? { get }
    
    // MARK: - Methods
    func fetchTvShows()
    func mappingTvAir(model: TVAiringTodayResponsesEntity)
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
    }
    
    func mappingTvAir(model: TVAiringTodayResponsesEntity) {
        let modelCell = mapper.tvAiring(model: model)
        dataTv.append(.airToday(model: modelCell))
        view?.showTvShows(model: dataTv)
    }
    
}
