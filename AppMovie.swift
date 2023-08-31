//
//  AppMovie.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 29/08/23.
//

import Foundation
import UIKit

struct Movie {
    var title: String
    var overview: String
    var releaseDate: String
    var popularity: Double
    var posterImagePath: String
    var rating: Double
    
    init(_ movie: APIMovie){
        title = movie.title
        overview = movie.overview
        releaseDate = movie.release_date
        popularity = movie.popularity
        posterImagePath = movie.poster_path
        rating = movie.vote_average
    }
}
