//
//  DetailTvResponseEntity.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 14/9/23.
//

import Foundation

struct DetailTvResponseEntity: Codable {
    
    let adult: Bool?
    let backdropPath: String?
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    let genres: [TvGenreResponseEntity]?
    let homepage: String?
    let id: Int?
    let inProduction: Bool?
    let languages: [String]?
    let lastAirDate: String?
    let name: String?
//    let networks: [Network]
    let numberOfEpisodes, numberOfSeasons: Int?
    let originCountry: [String]?
    let originalLanguage, originalName: String?
    let overview: String
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [Network]
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, type: String
    let voteCount: Int?
}

struct Network: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String
}

struct SpokenLanguage: Codable {
    let englishName, name: String
}
