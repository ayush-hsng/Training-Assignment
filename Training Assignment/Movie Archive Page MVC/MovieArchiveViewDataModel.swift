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
    var apiResponse: PopularMovieResult!
    var movies = [MovieArchiveCellDataModel]()
    
    //dependency
    var dataManager = DataManager.shared
    
    func fetchPopularMovies(){
        dataManager.requestJsonData(of: currentPage, from: API_URL_STRING) { (apiResponse) in
            if let response = apiResponse {
                self.apiResponse = response
                self.processResponse()
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
    
    func processResponse(){
        movies = apiResponse.results.map() { MovieArchiveCellDataModel(movieInfo: $0) }
        lastPage = apiResponse.total_pages
    }
    
    //Getter Methods
    
    func getMovieData(ofIndex index: Int) -> APIMovie {
        return apiResponse.results[index]
    }
    
    func getMovieInfo(ofIndex index: Int) -> MovieArchiveCellDataModel{
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
