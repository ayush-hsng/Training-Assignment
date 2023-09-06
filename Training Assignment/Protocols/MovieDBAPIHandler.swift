//
//  MovieDBAPIHandler.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 06/09/23.
//

import Foundation

protocol APIResponseHandler {
    var networkHandler: NetworkHandler { get set}
    var decoder: JSONDecoder {get set}
}

protocol PopularMoviesAPIHandler: APIResponseHandler {
    func requestPopularMovies(byPage page: Int, fromAPI urlString: String, onCompletion: @escaping (PopularMovieResult?)->(Void))
}

protocol SearchMovieAPIHandler: APIResponseHandler {
    func requestMovieWithTitle(withTitle title: String, fromAPI urlString: String, onCompletion: @escaping (MovieSearchResult?)->(Void))
}

protocol MovieDBAPIHandler: PopularMoviesAPIHandler, SearchMovieAPIHandler {
    
}
