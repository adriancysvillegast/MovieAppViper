//
//  TVAiringTodayResponsesEntity.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 13/9/23.
//

import Foundation

struct TVAiringTodayResponsesEntity: Codable {
    let page: Int
    let results: [TVAiringEntity]
    let totalPages, totalResults: Int
}


