//
//  TopRateResponseEntity.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 9/9/23.
//

import Foundation

struct TopRateResponseEntity: Codable {
    let page: Int
    let results: [TopRateEntity]
    let totalPages, totalResults: Int
}
