//
//  DataRequestHandler.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 06/09/23.
//

import Foundation
import UIKit

protocol RequestHandler{
    var requestBuilder: RequestBuilder! { get set}
}

protocol JsonDataRequestHandler: RequestHandler{
    func requestJsonData(from apiUrlString: String, using queryList: [String: String], onCompletion: @escaping (Data?)->(Void))
}

protocol ImageDataRequestHandler: RequestHandler {
    func requestImageData(from imageUrl: String,completionHandler: @escaping (UIImage?) -> (Void))
}

protocol DataRequestHandler: JsonDataRequestHandler, ImageDataRequestHandler {
    
}
