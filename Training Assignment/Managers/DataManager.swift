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

class DataManager {
    static let shared = DataManager()
    
    //Dependencies
    var requestBuilder : RequestBuilder!
    var networkHandler = NetworkHandler.shared
    var decoder = JSONDecoder()
    let session = URLSession.shared
    
    init() { }
    
    func requestJsonData(of page: Int = 1 ,from apiUrlString: String, completionhandler: @escaping (PopularMovieResult?)->(Void)) {
        
        let queryList = [   "api_key" : API_KEY,
                            "language" : LANG_CODE,
                            "page" : String(page)]
        
        requestBuilder = RequestBuilder(baseUrl: apiUrlString)
        requestBuilder.setQueryParameters(queryList: queryList)
        requestBuilder.setHTTPMethod(requestMethod: HTTPMethod.GET)
        requestBuilder.setHeader(headers: ["accept": "application/json"])
        
        if let request = requestBuilder.getRequest() {
            networkHandler.fetchData(using: request) { (data) in
                if let jsonData = data {
                    let responseData = try? self.decoder.decode(PopularMovieResult.self, from: jsonData)
                    completionhandler(responseData)
                }
            }
        }
    }
    
    func requestImageData(from imageFile: String,completionHandler: @escaping (UIImage?) -> (Void)){
        
        let urlString = POSTER_IMAGE_BASE_PATH + imageFile
        requestBuilder = RequestBuilder(baseUrl: urlString)
        
        if let request = requestBuilder.getRequest() {
            networkHandler.fetchData(using: request) { (data) in
                if let imageData = data {
                    completionHandler(UIImage(data: imageData))
                }
            }
        }
        
    }
    
}
