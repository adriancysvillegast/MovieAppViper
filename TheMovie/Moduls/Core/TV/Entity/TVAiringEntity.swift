//
//  TVAiringEntity.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 13/9/23.
//

import Foundation

struct TVAiringEntity: Codable {
    let backdropPath, firstAirDate: String
    let genreIds: [Int]
    let id: Int
    let name: String
    let originCountry: [String]
    let originalLanguage, originalName, overview: String
    let popularity: Double
    let posterPath: String
    let voteAverage: Double
    let voteCount: Int
}
