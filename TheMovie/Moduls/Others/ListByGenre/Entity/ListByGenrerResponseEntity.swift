//
//  ListByGenrerResponseEntity.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 17/9/23.
//

import Foundation

struct ListByGenrerResponseEntity: Codable {
    let page: Int
    let results: [ListByGenreEntity]
    let totalPages, totalResults: Int
}
