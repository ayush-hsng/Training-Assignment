//
//  MovieDetailsViewDataModel.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 31/08/23.
//
// File Responsibility - Define View Data Model from Movie Details Page
//      * Process and Store Movie Information *
//      * Notify View Controller when Processing is done( implements observable protocol) *
//      * provide Getter Methods *

import Foundation
import UIKit

class MovieDetailsViewDataModel: Observable {
    var observers: [UUID: Observer]
    
    class MovieInfo {
        var title: String
        var overview: String
        var releaseDate: String
        var popularity: Double
        var posterImagePath: String
        var rating: Double
        
        init(_ movie: APIMovie){
            title = movie.title
            overview = movie.overview
            releaseDate = movie.release_date
            popularity = movie.popularity
            posterImagePath = movie.poster_path
            rating = movie.vote_average
        }
    }
    
    var movieInfo: MovieInfo
    var moviePoster: UIImage!
    

    init(info: APIMovie){
        movieInfo = MovieInfo(info)
        observers = [UUID: Observer]()
    }

    
    //Setter Methods
    
    func setPoster(){
        ImageLoadManager.shared.loadImage(of: movieInfo.posterImagePath) { (image) in
            self.moviePoster = image
            self.notifyObservers()
        }
        
    }
    
    //Getter Methods
    
    func getTitle() -> String{
        return movieInfo.title
    }
    
    func getOverview() -> String {
        return movieInfo.overview
    }
    
    func getReleaseDate() -> String {
        return movieInfo.releaseDate
    }
    
    func getPopularity() -> String {
        return String(movieInfo.popularity)
    }
    
    func getRating() -> String {
        return String(movieInfo.rating)
    }
    
    func getPoster() -> UIImage {
        return moviePoster
    }
    
    //Observable protocol Methods
    
    func subscribe(observer: Observer) -> UUID{
        let observerID = UUID()
        observers[observerID] = observer
        return observerID
    }
    
    func unsubscribe(observerID : UUID) {
        self.observers.removeValue(forKey: observerID)
    }
    
    func notifyObservers() {
        for observer in observers.values {
            observer.notifyMeWhenDone()
        }
    }
}
