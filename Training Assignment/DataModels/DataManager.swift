//
//  DataManager.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 23/08/23.
//

import Foundation
import UIKit

class DataManager {
    
    static let session = URLSession.shared
    
    static func getPopularMoviesRequest(completionhandler: @escaping ([Movie]?)->(Void)) {
        let headers = ["accept": "application/json"]
        let urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=1"
        
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.GET.rawValue
        request.allHTTPHeaderFields = headers
        
        session.dataTask(with: request) { (data,response,error) in
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
    
    static func getMoviePosterRequest(from urlString: String,completionHandler: @escaping (UIImage?) -> (Void)){
        
        let url = URL(string: urlString)!
        
        session.dataTask(with: URLRequest(url: url)) { (data,response,error) in
            guard error == nil, let imageData = data else{
                completionHandler(nil)
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                completionHandler(nil)
                return
            }
            completionHandler(image)
        }.resume()
    }
}
