//
//  NetworkManager.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 31/08/23.
//
// File Responsbility - Define Data Manager
//      * create Request for fetching data from API Servers according to requeirements *
//      * convert fetched data to request type *

// App will provide closures(completionHandler) to fetch methods for using the data as and when required

import Foundation
import UIKit

class DataManager: MovieDBAPIHandler, DataRequestHandler {
    
    static let shared = DataManager()
    
    //Dependencies
    var requestBuilder: RequestBuilder!
    var networkHandler: NetworkHandler = NetworkHandler.shared
    var decoder: JSONDecoder = JSONDecoder()
    
    init() { }
    
    func requestJsonData(from apiUrlString: String, using queryList: [String: String], onCompletion: @escaping (Data?)->(Void)) {
        
        requestBuilder = RequestBuilder(baseUrl: apiUrlString)
        requestBuilder.setQueryParameters(queryList: queryList)
        requestBuilder.setHTTPMethod(requestMethod: HTTPMethod.GET)
        requestBuilder.setHeader(headers: ["accept": "application/json"])
        
        if let request = requestBuilder.getRequest() {
            networkHandler.fetchData(using: request) { (data) in
                onCompletion(data)
            }
        }
    }
    
    func requestImageData(from imageUrl: String,completionHandler: @escaping (UIImage?) -> (Void)){
        
        requestBuilder = RequestBuilder(baseUrl: imageUrl)
        
        if let request = requestBuilder.getRequest() {
            networkHandler.fetchData(using: request) { (data) in
                if let imageData = data {
                    completionHandler(UIImage(data: imageData))
                }
            }
        }
        
    }
    
    func requestPopularMovies(byPage page: Int, fromAPI urlString: String, onCompletion: @escaping (PopularMovieResult?)->(Void)){
        let queryList = [   "api_key" : API_KEY,
                            "language" : LANG_CODE,
                            "page" : String(page)]
        self.requestJsonData(from: urlString, using: queryList) { data in
            if let jsonData = data {
                let responseData = try? self.decoder.decode(PopularMovieResult.self, from: jsonData)
                onCompletion(responseData)
            }else {
                onCompletion(nil)
            }
        }
    }
    
    func requestMovieWithTitle(withTitle title: String, fromAPI urlString: String, onCompletion: @escaping (MovieSearchResult?)->(Void)){
        let queryList = [   "api_key" : API_KEY,
                            "language" : LANG_CODE,
                            "page" : "1",
                            "query" : title]
        self.requestJsonData(from: urlString, using: queryList) { data in
            if let jsonData = data {
                let responseData = try? self.decoder.decode(MovieSearchResult.self, from: jsonData)
                onCompletion(responseData)
            }else {
                onCompletion(nil)
            }
        }
        
    }
    
}
