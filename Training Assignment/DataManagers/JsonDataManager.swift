//
//  JsonDataManager.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 25/08/23.
//

import Foundation

class JsonDataManager {
    static let shared = JsonDataManager()
    
    private init() {    }
    
    func getPopularMoviesRequest(completionhandler: @escaping (PopularMovieResult?)->(Void)) {
        let headers = ["accept": "application/json"]
        
        let url = URL(string: API_URL_STRING)!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            guard error == nil, let jsonData = data else{
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Status code not 200")
                return
            }
            let responseData = try? JSONDecoder().decode(PopularMovieResult.self, from: jsonData)
            completionhandler(responseData)
        }.resume()
    }
}
