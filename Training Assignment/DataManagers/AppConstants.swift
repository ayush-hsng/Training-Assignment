//
//  AppConstants.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 28/08/23.
//

import Foundation


let apiUrlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=2"
    
let posterImageBasePath = "https://image.tmdb.org/t/p/w500/"
  
enum httpMethod: String {
    case GET
    case PUT
    case DELETE
    case PATCH
    case UPDATE
}
