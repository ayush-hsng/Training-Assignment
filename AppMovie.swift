//
//  AppMovie.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 29/08/23.
//

import Foundation
import UIKit

class AppMovie {
    var movieInfo: APIMovie
    var moviePoster: UIImage
    
    init(info: APIMovie, poster: UIImage){
        movieInfo = info
        moviePoster = poster
    }
    
    init(info: APIMovie){
        movieInfo = info
        moviePoster = ImageDataManager.shared.getPlaceholderImage()
    }
}
