//
//  TVPopularResponseEntity.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 14/9/23.
//

import Foundation

struct TVPopularResponseEntity: Codable {
    let page: Int
    let results: [TVPopularEntity]
    let totalPages, totalResults: Int
}
