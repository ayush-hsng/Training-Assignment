//
//  RequestBuilder.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 04/09/23.
//
// File Responsibility - Define Builder class for URLRequest
//      * provide Setters for setting various attributes of Request Object *
//      * provide Getter Method for Request object built *

import Foundation

class RequestBuilder {
    var urlComponents: URLComponents
    var requestHTTPMethod: String?
    var requestHeaders: [String: String]?
    var request: URLRequest!
    
    init(baseUrl: String){
        self.urlComponents = URLComponents(string: baseUrl) ?? URLComponents()
    }
    
    func setQueryParameters(queryList: [String: String]) {
        self.urlComponents.queryItems = queryList.map() { URLQueryItem(name: $0, value: $1)}
    }
    
    func setHTTPMethod(requestMethod: HTTPMethod) {
        self.requestHTTPMethod = requestMethod.rawValue
    }
    
    func setHeader(headers: [String: String]){
        self.requestHeaders = headers
    }
    
    func getRequest() -> URLRequest? {
        guard let url = self.urlComponents.url else {
            return nil
        }
        
        request = URLRequest(url: url)
        
        if let httpMethod = self.requestHTTPMethod {
            request.httpMethod = httpMethod
        }
        
        if let header = requestHeaders {
            request.allHTTPHeaderFields = header
        }
        
        return request
    }
}
