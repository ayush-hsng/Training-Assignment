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
    var searchMoviesInfo = [APIMovie]()
    var movies: [MoviesCellDataModel] = [MoviesCellDataModel]()
    var loadedPage: Int = 0
    var currentPage: Int = 1
    var lastPage: Int!
    var searchText: String!
    
    //dependency
    var dataManager: SearchMovieAPIHandler = DataManager.shared
    
    func loadNextPage(for title: String){
        dataManager.requestMovieWithTitle(withTitle: title, byPage: loadedPage + 1, fromAPI: API_SEARCH_MOVIES_URL_STRING) { (apiResponse) in
            if let response = apiResponse {
                self.loadedPage += 1
                self.searchMovieResults = response
                self.processMoviesWithTitleResults()
                self.notifyObservers()
            }
        }
    }
    
    func processMoviesWithTitleResults() {
        let movieLoaded = self.searchMovieResults.results.map() { MoviesCellDataModel(movieInfo: $0) }
        
        searchMoviesInfo.append(contentsOf: searchMovieResults.results)
        movies.append(contentsOf: movieLoaded)
        self.lastPage = self.searchMovieResults.total_pages
    }
    
    func getMovieData(ofIndex index: Int) -> APIMovie {
        return searchMoviesInfo[index]
    }
    
    func getMovieInfo(ofIndex index: Int) -> MoviesCellDataModel{
        return movies[index]
    }
    
    func getMovieCount() -> Int{
        return movies.count
    }
    
    func hasLoadablePage() -> Bool {
        return loadedPage < lastPage
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
