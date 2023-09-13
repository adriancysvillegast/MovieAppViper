//
//  AuthEntity.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 12/9/23.
//

import Foundation

struct AuthEntity: Codable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String
}
