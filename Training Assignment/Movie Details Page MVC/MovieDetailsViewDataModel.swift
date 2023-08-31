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
    
    var movieInfo: Movie
    var moviePoster: UIImage
    var posterLoaded: Bool
    
    init(info: Movie, poster: UIImage){
        movieInfo = info
        moviePoster = poster
        posterLoaded = true
    }
    
    init(info: Movie){
        movieInfo = info
        moviePoster = DataManager.shared.getPlaceholderImage()
        posterLoaded = false
    }
    
    func setPoster(){
        if !posterLoaded {
            DataManager.shared.getMoviePosterRequest(from: movieInfo.posterImagePath) { (image) in
                self.moviePoster = image
                self.posterLoaded = true
                self.notifyObserver()
            }
        }
        
    }
    
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
