//
//  MovieSearchViewDataModel.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 06/09/23.
//

import Foundation

class MovieSearchViewDataModel: Observable, MovieTableViewDataModelProtocol, PageControlHandler {
    var observers: [UUID : Observer] = [UUID: Observer]()
    var searchMovieResults: MovieSearchResult!
    var searchMoviesInfo = [APIMovie]()
    var movies: [MoviesCellDataModel] = [MoviesCellDataModel]()
    var loadedPage: Int = 0
    var lastPage: Int!
    var searchText: String!
    var loadingComplete: Bool = true
    
    //dependency
    var dataManager: SearchMovieAPIHandler = DataManager.shared
    
    func searchMovie(with title: String){
        self.searchText = title
        loadingComplete = false
        dataManager.requestMovieWithTitle(withTitle: title, byPage: 1, fromAPI: API_SEARCH_MOVIES_URL_STRING) { (apiResponse) in
            if let response = apiResponse {
                self.loadedPage = 1
                self.searchMovieResults = response
                self.processMoviesWithTitleResults()
                self.loadingComplete = true
                self.notifyAllObservers()
            }
        }
    }
    
    func processMoviesWithTitleResults() {
        searchMoviesInfo = searchMovieResults.results
        movies = self.searchMovieResults.results.map() { MoviesCellDataModel(movieInfo: $0) }
        self.lastPage = self.searchMovieResults.total_pages
    }
    
    // Page Control Handler Methods
    
    func loadNextPage(){
        loadingComplete = false
        dataManager.requestMovieWithTitle(withTitle: self.searchText, byPage: loadedPage + 1, fromAPI: API_SEARCH_MOVIES_URL_STRING) { (apiResponse) in
            if let response = apiResponse {
                self.loadedPage += 1
                self.searchMovieResults = response
                self.processLoadedResults()
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
    
    func processLoadedResults(){
        let movieLoaded = self.searchMovieResults.results.map() { MoviesCellDataModel(movieInfo: $0) }
        searchMoviesInfo.append(contentsOf: searchMovieResults.results)
        movies.append(contentsOf: movieLoaded)
        self.lastPage = self.searchMovieResults.total_pages
    }
    
    // Getter for MovieTableViewDataModelProtocol
    
    func getMovieData(ofIndex index: Int) -> APIMovie {
        return searchMoviesInfo[index]
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
