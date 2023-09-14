//
//  TVOnAirResponseEntity.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 14/9/23.
//

import Foundation

struct TVOnAirResponseEntity: Codable {
    let page: Int
    let results: [TVAiringEntity]
    let totalPages, totalResults: Int
}

