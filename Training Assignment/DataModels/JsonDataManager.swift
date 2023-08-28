//
//  JsonDataManager.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 25/08/23.
//

import Foundation

class JsonDataManager {
    
    static func getPopularMoviesRequest(completionhandler: @escaping ([Movie]?)->(Void)) {
        let headers = ["accept": "application/json"]
        
        let url = URL(string: apiUrlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.GET.rawValue
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
            completionhandler(responseData?.results)
        }.resume()
    }
}
