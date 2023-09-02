//
//  NetworkManager.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 31/08/23.
//

import Foundation
import UIKit

class DataManager {
    static let shared = DataManager()
    
    init() { }
    
    func fetchJsonDataRequest(from apiUrlString: String, completionhandler: @escaping (PopularMovieResult?)->(Void)) {
        let headers = ["accept": "application/json"]
        
        let url = URL(string: apiUrlString)!
        
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
    
    func fetchImageDataRequest(from imageFile: String,completionHandler: @escaping (UIImage?) -> (Void)){
        let urlString = POSTER_IMAGE_BASE_PATH + imageFile
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { (data,response,error) in
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
    
}
