//
//  MovieArchiveViewDataModel.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 29/08/23.
//

import Foundation
import UIKit

class MovieArchiveViewDataModel: Observable{
    var observer: Observer?
    var apiResponse: PopularMovieResult!
    var movies = [MovieArchiveCellDataModel]()
    
    
    
    func fetchPopularMovies(){
        DataManager.shared.fetchJsonDataRequest(from: API_URL_STRING) { (apiResponse) in
            if let response = apiResponse {
                self.apiResponse = response
                self.processResponse()
                self.notifyObserver()
            }
        }
    }
    
    func processResponse(){
        for movieData in apiResponse.results {
            movies.append(MovieArchiveCellDataModel(movieInfo: movieData))
        }
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
