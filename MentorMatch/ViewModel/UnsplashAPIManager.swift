//
//  UnsplashAPIManager.swift
//  MentorMatch
//
//  Created by Тася Галкина on 09.04.2024.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case noData
    case invalidResponse
}

protocol UnsplashAPIProtocol {
    static func getRandomPhoto(completion: @escaping (Result<String, Error>) -> Void)
}

class UnsplashAPIManager: ObservableObject, UnsplashAPIProtocol {
    static let baseURL = "https://api.unsplash.com"
    static let accessKey = "nEVFPBlEfIncdAbbFcuEk3PbRSmAzycD9ApSa35ihSk"
    
    static func getRandomPhoto(completion: @escaping (Result<String, Error>) -> Void) {
        let randomPhotoURL = "\(baseURL)/photos/random?client_id=\(accessKey)"
        
        guard let url = URL(string: randomPhotoURL) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let urls = json["urls"] as? [String: Any],
                   let regularURL = urls["regular"] as? String {
                    completion(.success(regularURL))
                } else {
                    completion(.failure(APIError.invalidResponse))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}



