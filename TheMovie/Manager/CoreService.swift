//
//  CoreService.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 8/9/23.
//

import Foundation

class CoreService {
    // MARK: - Properties
    static let shared = CoreService()
    private let requestBuilder: RequestBuilder = RequestBuilder()
    
    private init (){}
    
    private enum APIError: Error {
        case failedToGetData
        case invalidURL
    }
    
    // MARK: - Methods
    
    func get<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        requestBuilder.basicRequest(
            with: url,
            type: .GET) { request in
                let task = URLSession.shared.dataTask(
                    with: request) { data, _, error in
                        
                        guard let data = data, error == nil else {
                            completion(.failure(APIError.failedToGetData))
                            return
                        }
                        
                        do{
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let object = try decoder.decode(expecting, from: data)
                            completion(.success(object))
                        }
                        catch{
                            completion(.failure(error))
                        }
                    }
                task.resume()
            }
    }

}
