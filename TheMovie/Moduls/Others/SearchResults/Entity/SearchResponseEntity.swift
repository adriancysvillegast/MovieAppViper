//
//  SearchResponseEntity.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 15/9/23.
//

import Foundation

struct SearchResponseEntity: Codable {
    let page: Int
    let results: [SearchEntity]
    let totalPages, totalResults: Int

}
