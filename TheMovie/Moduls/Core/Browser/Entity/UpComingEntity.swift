//
//  UpComingEntity.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 9/9/23.
//

import Foundation

struct UpComingEntity: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let genreIds: [Int]
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

}
