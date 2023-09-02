//
//  ImageLoadManager.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 02/09/23.
//

import Foundation
import UIKit

class ImageLoadManager {
    static let shared = ImageLoadManager()
    var imageCache = [String: UIImage]()
    
    private init(){   }
    
    func loadImage(of filename: String, onCompletion: @escaping (UIImage) -> (Void)){
        guard let image = imageCache[filename] else {
            DataManager.shared.fetchImageDataRequest(from: filename){ (image) in
                self.imageCache[filename] = self.getImage(from: image)
                onCompletion(self.imageCache[filename]!)
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
