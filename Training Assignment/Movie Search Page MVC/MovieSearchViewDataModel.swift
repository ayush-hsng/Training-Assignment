//
//  MovieSearchViewDataModel.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 06/09/23.
//

import Foundation

class MovieSearchViewDataModel: Observable {
    var observers: [UUID : Observer] = [UUID: Observer]()
    var searchMovieResults: MovieSearchResult!
    var movies: [MoviesCellDataModel] = [MoviesCellDataModel]()
    var currentPage: Int = 1
    var lastPage: Int!
    
    //dependency
    var dataManager: SearchMovieAPIHandler = DataManager.shared
    
    func fetchMovisWithTitle(title: String) {
        dataManager.requestMovieWithTitle(withTitle: title, fromAPI: API_SEARCH_MOVIES_URL_STRING) { (apiResponse) in
            if let response = apiResponse {
                self.searchMovieResults = response
                self.processMoviesWithTitleResults()
                self.notifyObservers()
            }
        }
        
    }
    
    func processMoviesWithTitleResults() {
        self.movies = self.searchMovieResults.results.map() { MoviesCellDataModel(movieInfo: $0) }
        self.currentPage = self.searchMovieResults.page
        self.lastPage = self.searchMovieResults.total_pages
    }
    
    func getMovieData(ofIndex index: Int) -> APIMovie {
        return searchMovieResults.results[index]
    }
    
    func getMovieInfo(ofIndex index: Int) -> MoviesCellDataModel{
        return movies[index]
    }
    
    func getMovieCount() -> Int{
        return movies.count
    }
    
    func subscribe(observer: Observer) -> UUID {
        let uuid = UUID()
        self.observers[uuid] = observer
        return uuid
    }
    
    func unsubscribe(id: UUID) {
        self.observers.removeValue(forKey: id)
    }
    
    func notifyObservers() {
        for observer in self.observers.values {
            observer.notifyMeWhenDone()
        }
    }
    
    
}
