//
//  Helper.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 06/09/23.
//

import Foundation

class Helper {
    static func getImageUrlFrom(moviePoster: String) -> String {
        return POSTER_IMAGE_BASE_PATH + moviePoster
    }
    static func isValid(imageFile filename: String ) -> Bool{
        return filename.hasSuffix(".jpg")
    }
}
