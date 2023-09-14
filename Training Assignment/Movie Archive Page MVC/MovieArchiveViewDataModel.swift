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

class MovieArchiveViewDataModel: Observable, MovieTableViewDataModelProtocol, PageControlHandler{
    var observers = [UUID: Observer]()
    var loadedPage: Int = 0
    var lastPage: Int!
    var popularMoviesInfo = [APIMovie]()
    var movies = [MoviesCellDataModel]()
    var loadingComplete: Bool = true
    
    //dependency
    var dataManager: PopularMoviesAPIHandler = DataManager.shared
    var popularMoviesResults: PopularMovieResult!
    
    func loadNextPage(){
        loadingComplete = false
        dataManager.requestPopularMovies(byPage: loadedPage + 1, fromAPI: API_POPULAR_MOVIES_URL_STRING){ (apiResponse) in
            if let response = apiResponse {
                self.loadedPage += 1
                self.popularMoviesResults = response
                self.processPopularMoviesResults()
                self.loadingComplete = true
                self.notifyAllObservers()
            }
        }
    }
    
    func isLoadingComplete() -> Bool {
        return loadingComplete
    }
    
    func loadedLastPage() -> Bool {
        return self.loadedPage == self.lastPage
    }

    func processPopularMoviesResults(){
        
        let movieLoaded = popularMoviesResults.results.map() { MoviesCellDataModel(movieInfo: $0) }
        
        movies.append(contentsOf: movieLoaded)
        popularMoviesInfo.append(contentsOf: popularMoviesResults.results)
        lastPage = popularMoviesResults.total_pages
    }
    
    //Getter Methods
    
    func getMovieData(ofIndex index: Int) -> APIMovie {
        return popularMoviesInfo[index]
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
    
    func unsubscribe(observer: Observer) {
        self.observers.removeValue(forKey: observer.observerID)
    }
    
    func notifyObserver(with observerID: UUID) {
        observers[observerID]?.notifyMeWhenDone()
    }
    
    func notifyAllObservers() {
        for observer in observers.values {
            observer.notifyMeWhenDone()
        }
    }
}
