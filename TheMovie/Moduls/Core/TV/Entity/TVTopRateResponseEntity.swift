//
//  TVTopRateResponseEntity.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 14/9/23.
//

import Foundation

struct TVTopRateResponseEntity: Codable {
    let page: Int
    let results: [TVTopRateEntity]
    let totalPages, totalResults: Int
}
