//
//  ImageDataManager.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 25/08/23.
//

import Foundation
import UIKit

class ImageDataManager {
    static func getMoviePosterRequest(from imageFile: String,completionHandler: @escaping (UIImage) -> (Void)){
        let posterImageBasePath = "https://image.tmdb.org/t/p/w500/"
        let urlString = posterImageBasePath + imageFile
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { (data,response,error) in
            guard error == nil, let imageData = data else{
                completionHandler(getImage())
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Status code not 200")
                completionHandler(getImage())
                return
            }
            completionHandler(getImage(from: UIImage(data: imageData)))
        }.resume()
    }
    
    static func getImage(from optionalImage: UIImage? = nil) -> UIImage{
        if let unwrappedImage = optionalImage {
            return unwrappedImage
        }else {
            let defaultImageName = "photo"
            let defaultImage = UIImage(systemName: defaultImageName)!
            return defaultImage
        }
    }
}
