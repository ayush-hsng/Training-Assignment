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

class ImageLoadManager {
    static let shared = ImageLoadManager()
    let dataManager = DataManager.shared
    var imageCache = [String: UIImage]()
    
    private init(){   }
    
    func loadImage(of filename: String, onCompletion: @escaping (UIImage) -> (Void)){
        guard let image = imageCache[filename] else {
            dataManager.fetchImageDataRequest(from: filename){ (image) in
                if let image = image {
                    self.imageCache[filename] = image
                }
                onCompletion(self.getImage(from: image))
            }
            return
        }
        onCompletion(image)
    }

    func invalidateCahce(){
        imageCache.removeAll()
    }
    
    func getPlaceholderImage() -> UIImage{
        let defaultImageName = "photo"
        let defaultImage = UIImage(systemName: defaultImageName)!
        return defaultImage
    }
    
    func getImage(from optionalImage: UIImage? = nil) -> UIImage{
        if let unwrappedImage = optionalImage {
            return unwrappedImage
        }else {
            return self.getPlaceholderImage()
        }
    }
    
    deinit{
        self.invalidateCahce()
    }
}