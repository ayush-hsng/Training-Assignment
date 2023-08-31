//
//  AppConstants.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 28/08/23.
//

import Foundation


let API_URL_STRING = "https://api.themoviedb.org/3/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=2"
    
let POSTER_IMAGE_BASE_PATH = "https://image.tmdb.org/t/p/w500/"
  
enum HTTPMethod: String {
    case GET
    case PUT
    case DELETE
    case PATCH
    case UPDATE
}
