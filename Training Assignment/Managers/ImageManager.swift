//
//  ImageLoadManager.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 02/09/23.
//
// File Responsibility - Define Manager Class serves load Image Request from App
//      * Load Image (transfer request to DataManager Class if not loaded already) *
//      * Failure Management (pass placeholder Image) *
//      * Image Cache Management *


import Foundation
import UIKit

class ImageManager: ImageLoader, ImageCaheHandler {
    
    static let shared = ImageManager()
    var imageCache = [String: UIImage]()
    
    //Dependency
    let imageDataRequestHandler: ImageDataRequestHandler
    
    private init(){
        imageDataRequestHandler = DataManager.shared
    }
    
    func loadImage(from urlString: String, onCompletion: @escaping (UIImage) -> (Void)) {
        if let image = imageCache[urlString] {
            onCompletion(image)
            return
        }
        
        imageDataRequestHandler.requestImageData(from: urlString){ (image) in
            if let image = image {
                self.imageCache[urlString] = image
                onCompletion(image)
                return
            }
            
            onCompletion(self.getPlaceholderImage())
        }
    }

    func invalidateCache(){
        imageCache.removeAll()
    }
    
    func getPlaceholderImage() -> UIImage{
        let defaultImageName = "photo"
        let defaultImage = UIImage(systemName: defaultImageName)!
        return defaultImage
    }
    
    
    deinit{
        self.invalidateCache()
    }
}
