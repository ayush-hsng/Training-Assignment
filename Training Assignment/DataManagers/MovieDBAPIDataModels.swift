//
//  MovieDBAPIDataModels.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 28/08/23.
//

import Foundation

struct APIMovie: Codable {
    var adult: Bool
    var backdrop_path: String
    var genre_ids: [Int]
    var id: Int
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Double
    var poster_path: String
    var release_date: String
    var title: String
    var video: Bool
    var vote_average: Double
    var vote_count: Int
}
struct Interval: Codable {
    var maximum: String
    var minimum: String
}

struct PopularMovieResult: Codable {
    var dates: Interval
    var page: Int
    var results: [APIMovie]
    var total_pages: Int
    var total_results: Int
}


