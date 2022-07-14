//
//  APICaller.swift
//  Netflix Clone
//
//  Created by eunji on 2022/07/13.
//

import Foundation

struct Constants {
    static let API_KEY = "5ce0f85f358b7ee4bca2933b1133cdf6"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    /* URLSession
     : HTTP/HTTPS를 통해 data를 주고받는 API를 제공하는 class.
     
     */
    
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
//                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                /* JSON.Serialization.jsonObject()
                 : JSON <-> Array / Dictionary 형태로 변환
                 - Array / Dictionary 형태로 만드는게 아닐 경우 options: .fragmentsAllowed로 해야함.
                 */
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume() // DataTask 시작
    }
}
