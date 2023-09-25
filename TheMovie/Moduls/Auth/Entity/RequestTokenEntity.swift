//
//  RequestTokenEntity.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 12/9/23.
//

import Foundation

struct RequestTokenEntity: Codable {
    let success: Bool
    let expiresAt: String
    let requestToken: String
}

