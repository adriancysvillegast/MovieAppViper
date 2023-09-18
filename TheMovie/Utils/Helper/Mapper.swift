//
//  Mapper.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 8/9/23.
//

import Foundation

struct Mapper {
    
    // MARK: - Movies
    
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
    
    // MARK: - TV Shows
    func tvAiring(model: TVAiringTodayResponsesEntity) -> [TvAiringTodayViewModelCell] {
        let modelCell = model.results.compactMap {
            TvAiringTodayViewModelCell(
                id: $0.id,
                posterPath: URL(string: "https://image.tmdb.org/t/p/w200" + ($0.posterPath ?? "") ),
                title: $0.originalName,
                overview: $0.overview
            )
            }
        return modelCell
    }
    
    func tvOnAir(model: TVOnAirResponseEntity) -> [TvOnAirViewModelCell] {
        let modelCell = model.results.compactMap {
            TvOnAirViewModelCell(
                id: $0.id,
                posterPath: URL(string: "https://image.tmdb.org/t/p/w200" + ($0.posterPath ?? "")),
                title: $0.originalName,
                overview: $0.overview
            )
            }
        return modelCell
    }
    
    func tvPopular(model: TVPopularResponseEntity) -> [TvPopularViewModelCell] {
        let modelCell = model.results.compactMap {
            TvPopularViewModelCell(
                id: $0.id,
                posterPath: URL(string: "https://image.tmdb.org/t/p/w200" + $0.posterPath),
                title: $0.originalName,
                overview: $0.overview
            )
            }
        return modelCell
    }
    
    func tvTopRate(model: TVTopRateResponseEntity) -> [TvTopRateViewModelCell] {
        let modelCell = model.results.compactMap {
            TvTopRateViewModelCell(
                id: $0.id,
                posterPath: URL(string: "https://image.tmdb.org/t/p/w200" + $0.posterPath),
                title: $0.originalName,
                overview: $0.overview
            )
            }
        return modelCell
    }
    
    func detailTV(model: DetailTvResponseEntity) -> DetailTvViewModelCell {
        //Images
        let genres = model.genres.compactMap { $0.name }.joined(separator: ", ")
        var companyURL: [URL?] = []
        
        let companiesImages = model.productionCompanies.compactMap{  $0.logoPath }
        companiesImages.forEach { companyURL.append(URL(string: "https://image.tmdb.org/t/p/w200" + $0))
        }
        
        var description = "Without description"
        if model.overview != "" {
            description = model.overview
        }
        
        let modelCell = DetailTvViewModelCell(artWork: URL(string: "https://image.tmdb.org/t/p/w200" + (model.posterPath ?? "")), title: model.name, description: description, genre: genres, language: model.originalLanguage, popularity: model.popularity.description, prodCompanies: companyURL)
        
        return modelCell
    }
        
    func searchResult(model: SearchResponseEntity) -> [SearchResultViewModelCell] {
        let modelCell = model.results.compactMap {
            SearchResultViewModelCell(
                id: $0.id,
                posterPath: URL(string: "https://image.tmdb.org/t/p/w200" + ($0.posterPath ?? "")),
                title: $0.title
            )
            }
        return modelCell
    }

    func mappingGenre(model: ResultGenreResponseEntity) -> [GenreViewModelCell] {
        let modelCell = model.genres.compactMap {
            GenreViewModelCell(id: $0.id.description, name: $0.name)
        }
        return modelCell
    }
    
    func mappingListByGenre(model: ListByGenrerResponseEntity) -> [ListByGenreViewModelCell] {
        let modelCell = model.results.compactMap {
            ListByGenreViewModelCell(
                id: $0.id,
                posterPath: URL(string: "https://image.tmdb.org/t/p/w200" + ($0.posterPath ?? "")),
                title: $0.title
            )
        }
        return modelCell
    }
}
