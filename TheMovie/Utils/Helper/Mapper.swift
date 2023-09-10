//
//  Mapper.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 8/9/23.
//

import Foundation

struct Mapper {
    
    // MARK: - Popular Movies
    
    func popularMovie(model: PopularMoviesResponseEntity) -> [PopularViewModelCell] {
        let movies = model.results.compactMap {
            PopularViewModelCell(posterPath: URL(string: "https://image.tmdb.org/t/p/w200" + $0.posterPath) ,
                                 title: $0.title,
                                 overview: $0.overview)
        }
        return movies
    }
    
    func nowPlayingMovie(model: NowPlayingResponseEntity) -> [NowPlayingViewModelCell] {
        let movies = model.results.compactMap {
            NowPlayingViewModelCell(posterPath: URL(string: "https://image.tmdb.org/t/p/w200" + $0.posterPath) ,
                                 title: $0.title,
                                 overview: $0.overview)
        }
        return movies
    }
    
    func topRateMovie(model: TopRateResponseEntity) -> [TopRateViewModelCell] {
        let movies = model.results.compactMap {
            TopRateViewModelCell(posterPath: URL(string: "https://image.tmdb.org/t/p/w200" + $0.posterPath) ,
                                 title: $0.title,
                                 overview: $0.overview)
        }
        return movies
    }
    
    func upComingMovie(model: UpComingResponseEntity) -> [UpComingViewModelCell] {
        let movies = model.results.compactMap {
            UpComingViewModelCell(posterPath: URL(string: "https://image.tmdb.org/t/p/w200" + $0.posterPath) ,
                                 title: $0.title,
                                 overview: $0.overview)
        }
        return movies
    }
    
}
