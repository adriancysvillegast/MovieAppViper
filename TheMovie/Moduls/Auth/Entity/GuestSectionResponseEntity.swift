//
//  GuestSectionResponseEntity.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 19/9/23.
//

import Foundation

struct GuestSectionResponseEntity: Codable {
    let success: Bool
    let guestSessionId: String
    let expiresAt: String
}
