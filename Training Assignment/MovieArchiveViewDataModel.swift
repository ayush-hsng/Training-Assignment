//
//  MovieArchiveViewDataModel.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 29/08/23.
//

import Foundation

class MovieArchiveViewDataModel: Subject{
    var observer: Observer?
    var apiResponse: PopularMovieResult!
    var popularMovies = [Movie]()
    
    func subscribe(observer: Observer) {
        self.observer = observer
    }
    
    func unsubscribe() {
        self.observer = nil
    }
    
    func fetchPopularMovies(){
        JsonDataManager.shared.getPopularMoviesRequest { (apiResponse) in
            if let response = apiResponse {
                self.apiResponse = response
                self.filterResponse()
                self.notifyObserver()
            }
        }
    }
    
    func getPopularMovie(by index: Int) -> Movie{
        return popularMovies[index]
    }
    
    func getPopularMovieCount() -> Int{
        return popularMovies.count
    }
    
    func filterResponse(){
        for movieData in apiResponse.results {
            popularMovies.append(Movie(movieData))
        }
    }
    
    func notifyObserver() {
        observer?.notifyMeWhenDone()
    }
    
}
