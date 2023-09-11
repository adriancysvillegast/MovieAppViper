//
//  BrowserPresenter.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 8/9/23.
//

import Foundation

// MARK: - BrowserType

enum BrowserType {
    case topRate(model: [TopRateViewModelCell])
    case upComing(model: [UpComingViewModelCell])
    case popularMovies(model: [PopularViewModelCell])
    case nowPlaying(model: [NowPlayingViewModelCell])
    
    var title: String {
        switch self {
        
        case .popularMovies:
            return "Popular Movies"
        case .nowPlaying:
            return "Now Playing"
        case .topRate:
            return "Top Rate"
        case .upComing:
            return "Up Coming"
        
        }
    }
}

// MARK: - BrowserPresentable
protocol BrowserPresentable: AnyObject {
//    Properties
    var view: BrowserViewDelegate? { get }
    var dataBrowser: [BrowserType] { get }

//    Methods
    func fetchAllMovieEndPoints()
    func didSuccessPopularMovie(model: PopularMoviesResponseEntity)
    func didSuccessNowPlaying(model: NowPlayingResponseEntity)
    func didSuccessTopRate(model: TopRateResponseEntity)
    func didSuccessUpComing(model: UpComingResponseEntity)
    func onTapMovie(movieID: Int)
    func didFailure(message: String)
    
}


class BrowserPresenter: BrowserPresentable {
    

    // MARK: - Properties
    weak var view: BrowserViewDelegate?
    private var interactor: BrowserInteractable?
    var mapper: Mapper
    private let router: BrowserRouting

    var dataBrowser: [BrowserType] = []

    // MARK: - Init
    
    init(interactor: BrowserInteractable,
         router: BrowserRouting,
         mapper: Mapper = Mapper()) {
        
        self.interactor = interactor
        self.router = router
        self.mapper = mapper
    }
    
    // MARK: - Methods
    func fetchAllMovieEndPoints() {
        interactor?.getPopularMovies()
        interactor?.getNowPlaying()
        interactor?.getTopRate()
        interactor?.getUpComing()
    }

    
    func didSuccessPopularMovie(model: PopularMoviesResponseEntity) {
        let movieCell = mapper.popularMovie(model: model)
        dataBrowser.append(.popularMovies(model: movieCell))
    }
    
    func didSuccessNowPlaying(model: NowPlayingResponseEntity) {
        let movieCell = mapper.nowPlayingMovie(model: model)
        dataBrowser.append(.nowPlaying(model: movieCell))
    }
    
    func didSuccessTopRate(model: TopRateResponseEntity) {
        let movieCell = mapper.topRateMovie(model: model)
        dataBrowser.append(.topRate(model: movieCell))

    }
    
    func didSuccessUpComing(model: UpComingResponseEntity) {
        let movieCell = mapper.upComingMovie(model: model)
        dataBrowser.append(.upComing(model: movieCell))
        view?.updateView(model: dataBrowser)
    }
    
    func onTapMovie(movieID: Int) {
        let id = movieID.description
        router.showDetailMovie(movieID: id)
    }

    func didFailure(message: String) {
        view?.showError(message: message)
    }


}
