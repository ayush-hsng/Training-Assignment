//
//  MovieArchiveCellDataModel.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 02/09/23.
//

import Foundation
import UIKit

class MovieArchiveCellDataModel {
    
    var title: String
    var overview: String
    var posterImagePath: String
    
    init(movieInfo: APIMovie) {
        self.title = movieInfo.title
        self.overview = movieInfo.overview
        self.posterImagePath = movieInfo.poster_path
    }
    
    //getters
    func getTitle() -> String {
        return self.title
    }
    
    func getOverview() -> String {
        return self.overview
    }
    
    func getPosterFile() -> String {
        return self.posterImagePath
    }
    
}
