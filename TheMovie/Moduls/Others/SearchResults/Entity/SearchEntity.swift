//
//  SearchEntity.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 15/9/23.
//

import Foundation

struct SearchEntity: Codable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

}
