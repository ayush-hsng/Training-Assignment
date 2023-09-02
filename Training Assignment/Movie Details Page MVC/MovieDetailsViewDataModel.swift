//
//  MovieDetailsViewDataModel.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 31/08/23.
//

import Foundation
import UIKit

class MovieDetailsViewDataModel: Observable {
    var observer: Observer?
    
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
    }

    
    //Setter Methods
    
    func setPoster(){
        ImageLoadManager.shared.loadImage(of: movieInfo.posterImagePath) { (image) in
            self.moviePoster = image
            self.notifyObserver()
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
