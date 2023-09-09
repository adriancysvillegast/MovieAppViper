//
//  PopularMoviesResponseEntity.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 8/9/23.
//

import Foundation

struct PopularMoviesResponseEntity: Codable {
    let page: Int
    let results: [PopularMovieEntity]
    let totalPages, totalResults: Int
}
