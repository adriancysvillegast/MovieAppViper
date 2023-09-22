//
//  NowPlayingResponseEntity.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 9/9/23.
//

import Foundation

struct NowPlayingResponseEntity: Codable {
    let page: Int
    let results: [NowPlayingEntity]
    let totalPages, totalResults: Int
    
}
