//
//  MovieDBAPIDataModels.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 28/08/23.
//
// File Responsibility - Define Data Types compatible to JSON response from the Movie-DB API, for parsing

import Foundation

// Structure Responsibility - Define Movie structure compatible to Movie results fetched from API
struct APIMovie: Codable {
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_language: String?
    var original_title: String?
    var overview: String
    var popularity: Double
    var poster_path: String
    var release_date: String
    var title: String
    var video: Bool?
    var vote_average: Double
    var vote_count: Int?
}

// Structure Resposibility - Define Time Interval(of Dates) compatible to nested object type-"dates" in API response
struct Interval: Codable {
    var maximum: String?
    var minimum: String?
}

// Structure Resposibility - Define structure compatible to object type of API get response
struct PopularMovieResult: Codable {
    var dates: Interval?
    var page: Int
    var results: [APIMovie]
    var total_pages: Int
    var total_results: Int?
}


