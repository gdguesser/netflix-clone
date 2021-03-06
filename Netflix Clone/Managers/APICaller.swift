//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Gabriel Guesser on 20/02/22.
//

import Foundation

struct Constants {
    static let API_KEY = "61d16d42cfebfbb6a171402ba4834211"
    static let BASE_URL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
                
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
        }
        
        do {
            let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
            completion(.success(results.results))
            
        } catch {
            completion(.failure(error))
        }
        }
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.BASE_URL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
        }
        
        do {
            let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            print(results)
        } catch {
            print(error.localizedDescription)
        }
        }
        task.resume()
    }
}
