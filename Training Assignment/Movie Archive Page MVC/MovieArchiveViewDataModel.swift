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
    var observer: Observer?
    var apiResponse: PopularMovieResult!
    var movies = [MovieArchiveCellDataModel]()
    
    //dependency
    var dataManager = DataManager.shared
    
    func fetchPopularMovies(){
        dataManager.requestJsonData(from: API_URL_STRING) { (apiResponse) in
            if let response = apiResponse {
                self.apiResponse = response
                self.processResponse()
                self.notifyObserver()
            }
        }
    }
    
    func processResponse(){
        movies = apiResponse.results.map() { MovieArchiveCellDataModel(movieInfo: $0) }
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
    
    func subscribe(observer: Observer) {
        self.observer = observer
    }
    
    func unsubscribe() {
        self.observer = nil
    }
    
    func notifyObserver() {
        observer?.notifyMeWhenDone()
    }
}
