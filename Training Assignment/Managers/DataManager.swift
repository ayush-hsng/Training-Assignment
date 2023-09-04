//
//  NetworkManager.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 31/08/23.
//
// File Responsbility - Define Network Manager, which fetches data from API servers
//      * Fetch Data from Internet(perfrom Network Calls) *

// App will provide closures(completionHandler) to fetch methods for using the data as and when required

import Foundation
import UIKit

class DataManager {
    static let shared = DataManager()
    let session = URLSession.shared
    
    init() { }
    
    func fetchJsonDataRequest(from apiUrlString: String, completionhandler: @escaping (PopularMovieResult?)->(Void)) {
        let headers = ["accept": "application/json"]
        
        let url = URL(string: apiUrlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.allHTTPHeaderFields = headers
        
        session.dataTask(with: request) { (data,response,error) in
            guard error == nil, let jsonData = data else{
                completionhandler(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Status code not 200")
                completionhandler(nil)
                return
            }
            let responseData = try? JSONDecoder().decode(PopularMovieResult.self, from: jsonData)
            completionhandler(responseData)
        }.resume()
    }
    
    func fetchImageDataRequest(from imageFile: String,completionHandler: @escaping (UIImage?) -> (Void)){
        let urlString = POSTER_IMAGE_BASE_PATH + imageFile
        let url = URL(string: urlString)!
        
        session.dataTask(with: URLRequest(url: url)) { (data,response,error) in
            guard error == nil, let imageData = data else{
                completionHandler(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Status code not 200")
                completionHandler(nil)
                return
            }
            completionHandler(UIImage(data: imageData))
        }.resume()
    }
    
//    func buildURLRequest(from urlString: String, and queryList: [String: String]) {
//        var urlComponents = URLComponents(string: urlString)
//        urlComponents?.queryItems = queryList.map { URLQueryItem(name: $0, value: $1) }
//
//        guard let url = urlComponents?.url else {
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = HTTPMethod.GET.rawValue
//        request.allHTTPHeaderFields =
//    }
    
}
