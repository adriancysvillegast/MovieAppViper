//
//  RequestBuilder.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 8/9/23.
//

import Foundation

class RequestBuilder {
    
    // MARK: - Properties
    
    enum HTTPMethods: String {
        case GET
        case PUT
        case POST
        case DELETE
    }
    
    // MARK: - Basic Request
    func basicRequest(with url: URL?, type: HTTPMethods,
                       completion: @escaping (URLRequest) -> Void) {
        guard let apiUrl = url else {
            return
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        completion(request)
    }
}
