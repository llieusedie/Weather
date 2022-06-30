//
//  NetworkManager.swift
//  Clima
//
//  Created by Paul Kirnoz on 20.06.2022.
//

import Foundation

///IT'S A NETWORK MANAGER THAT IS RESPONSIBLE FOR MAKING ALL THE INTERNAL API CALLS
final class NetworkManager<T: Codable> {
    static func fetch(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            ///networking proceeds only if an error is nil
            guard error == nil else {
                print(String(describing: error!))
                completion(.failure(.error(err: error!.localizedDescription)))
                return
            }
            ///check if the response is 200 so there will be some information
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            ///safely unwraps give data
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            ///if all of the above steps are passed – means we have some sort of data to work with
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
                
            } catch let err {
                print(String(describing: err))
                completion(.failure(.decodingError(err: err.localizedDescription)))
            }
            
            
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case error(err: String)
    case decodingError(err: String)
}
