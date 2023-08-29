//
//  MovieDBAPIDataModels.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 28/08/23.
//

import Foundation

struct APIMovie: Codable {
    var title: String
    var overview: String
    var popularity: Double
    var release_date: String
    var vote_average: Double
    var poster_path: String
}

struct PopularMovieResult: Codable {
    var results: [APIMovie]
}

