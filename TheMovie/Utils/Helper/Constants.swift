//
//  Constants.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 20/9/23.
//

import Foundation

struct Constants {
    static let baseURL = ProcessInfo.processInfo.environment["baseURL"] ?? "https://api.themoviedb.org/3"
    static let apiToken = ProcessInfo.processInfo.environment["token"] ?? ""

}
