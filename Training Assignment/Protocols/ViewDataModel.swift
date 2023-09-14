//
//  ViewDataModel.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 12/09/23.
//

import Foundation
import UIKit

protocol MovieTableViewDataModelProtocol {
        
    func getMovieCount() -> Int
    func getMovieInfo(ofIndex index: Int) -> MoviesCellDataModel
    func getMovieData(ofIndex index: Int) -> APIMovie
}

protocol MoviesCellDataModelProtocol {
    func getTitle() -> String
    
    func getOverview() -> String
    
    func getPosterFile() -> String
    
}

protocol PageControlHandler {
    var lastPage: Int! { get set }
    var loadedPage: Int { get set }

    
    func loadNextPage()
    func loadedLastPage() -> Bool
    func isLoadingComplete() -> Bool
}

protocol MovieDetailsViewDataModelProtocol {
    func getTitle() -> String
    
    func getOverview() -> String
    
    func getReleaseDate() -> String
    
    func getPopularity() -> String
    
    func getRating() -> String
    
    func getPoster() -> UIImage 
}

