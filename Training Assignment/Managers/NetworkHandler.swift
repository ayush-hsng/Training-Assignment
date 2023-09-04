//
//  NetworkHandler.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 04/09/23.
//
// File Responsbility - define Network Handler Class
//      * handles api calls *

import Foundation

class NetworkHandler {
    static var shared = NetworkHandler()
    let session = URLSession.shared
    private init() {  }
    
    func fetchData(using request: URLRequest, onCompletion: @escaping (Data?) -> (Void)) {
        session.dataTask(with: request) { (data,response,error) in
            guard error == nil, let data = data else{
                onCompletion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Status code not 200")
                onCompletion(nil)
                return
            }
            onCompletion(data)
        }.resume()
    }
}
