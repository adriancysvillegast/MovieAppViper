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
            PopularViewModelCell(
                id:$0.id ,
                posterPath: URL(string: "https://image.tmdb.org/t/p/w200" + $0.posterPath) ,
                title: $0.title,
                overview: $0.overview)
        }
        return movies
    }
    
    func nowPlayingMovie(model: NowPlayingResponseEntity) -> [NowPlayingViewModelCell] {
        let movies = model.results.compactMap {
            NowPlayingViewModelCell(
                id:$0.id ,
                posterPath: URL(string: "https://image.tmdb.org/t/p/w200" + $0.posterPath) ,
                title: $0.title,
                overview: $0.overview)
        }
        return movies
    }
    
    func topRateMovie(model: TopRateResponseEntity) -> [TopRateViewModelCell] {
        let movies = model.results.compactMap {
            TopRateViewModelCell(
                id:$0.id ,
                posterPath: URL(string: "https://image.tmdb.org/t/p/w200" + $0.posterPath) ,
                title: $0.title,
                overview: $0.overview)
        }
        return movies
    }
    
    func upComingMovie(model: UpComingResponseEntity) -> [UpComingViewModelCell] {
        let movies = model.results.compactMap {
            UpComingViewModelCell(
                id:$0.id ,
                posterPath: URL(string: "https://image.tmdb.org/t/p/w200" + $0.posterPath) ,
                title: $0.title,
                overview: $0.overview)
        }
        return movies
    }
    
    func detailMovie(model: DetailMovieResponseEntity) -> DetailMovieViewModelCell {
        //Images
        let genres = model.genres.compactMap { $0.name }.joined(separator: ", ")
        var companyURL: [URL?] = []
        
        let companiesImages = model.productionCompanies.compactMap{  $0.logoPath }
        companiesImages.forEach { companyURL.append(URL(string: "https://image.tmdb.org/t/p/w200" + $0))
        }
        
        let modelCell = DetailMovieViewModelCell(artWork: URL(string: "https://image.tmdb.org/t/p/w200" + (model.posterPath ?? "")), title: model.title, description: model.overview, genre: genres, language: model.originalLanguage, popularity: model.popularity.description, prodCompanies: companyURL)
        
        return modelCell
    }
    
}