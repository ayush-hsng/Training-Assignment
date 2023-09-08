//
//  MovieArchiveViewDataModel.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 29/08/23.
//
// File Responsibility - Define Data Model for Movie Archive Page
//      * fetch and store Data for movie from api handler *
//      * process data( make data model instances for movie cells) *
//      * notify view controller when processing is done( implement observable protocol) *
//      * provide Getter Methods *

import Foundation
import UIKit

class MovieArchiveViewDataModel: Observable{
    var observers = [UUID: Observer]()
    var currentPage: Int = 1
    var lastPage: Int!
    var popularMoviesResults: PopularMovieResult!
//    var moviesWithTitleResults: MovieSearchResult!
    var movies = [MoviesCellDataModel]()
    
    //dependency
    var dataManager: PopularMoviesAPIHandler = DataManager.shared
    
    func fetchPopularMovies(fromHome: Bool = false){
        if fromHome {
            self.currentPage = 1
        }
        dataManager.requestPopularMovies(byPage: currentPage, fromAPI: API_POPULAR_MOVIES_URL_STRING){ (apiResponse) in
            if let response = apiResponse {
                self.popularMoviesResults = response
                self.processPopularMoviesResults()
                self.notifyObservers()
            }
        }
    }
    

    
    func gotoPrevPage() {
        currentPage -= 1
        fetchPopularMovies()
    }
    
    func gotoNextPage() {
        currentPage += 1
        fetchPopularMovies()
    }
    
    func processPopularMoviesResults(){
        movies = popularMoviesResults.results.map() { MoviesCellDataModel(movieInfo: $0) }
        lastPage = popularMoviesResults.total_pages
    }
    
    //Getter Methods
    
    func getMovieData(ofIndex index: Int) -> APIMovie {
        return popularMoviesResults.results[index]
    }
    
    func getMovieInfo(ofIndex index: Int) -> MoviesCellDataModel{
        return movies[index]
    }
    
    func getMovieCount() -> Int{
        return movies.count
    }
    
    // Observable Protocol methoods
    
    func subscribe(observer: Observer) -> UUID{
        let observerID = UUID()
        observers[observerID] = observer
        return observerID
    }
    
    func unsubscribe(id: UUID) {
        self.observers.removeValue(forKey: id)
    }
    
    func notifyObservers() {
        for observer in observers.values {
            observer.notifyMeWhenDone()
        }
    }
}
