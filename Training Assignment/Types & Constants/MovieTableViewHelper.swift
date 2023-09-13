//
//  MovieTableViewHelper.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 12/09/23.
//

import Foundation
import UIKit



class MovieTableViewDataSource: NSObject, UITableViewDataSource {
    
    //dependency
    var viewDataModel: MovieTableViewDataModelProtocol
    
    init(viewDataModel: MovieTableViewDataModelProtocol) {
        self.viewDataModel = viewDataModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewDataModel.getMovieCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)

        guard let cell = cell as? MoviesTableViewCell else {
            return cell
        }

        cell.cellDataModel = self.viewDataModel.getMovieInfo(ofIndex: indexPath.row)
        cell.setCellElements()

        return cell
    }
}

class MovieTableViewDelegate: NSObject, UITableViewDelegate {
    
    //dependency
    var viewController: UIViewController
    var pageControlManager : PageControlHandler
    
    init(viewController: UIViewController,pageControlManager: PageControlHandler) {
        self.viewController = viewController
        self.pageControlManager = pageControlManager
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewController.performSegue(withIdentifier: "CheckMovieSegue", sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.pageControlManager.loadedLastPage() {
            tableView.tableFooterView = nil
        }else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            if tableView.tableFooterView == nil {
                let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: cell.bounds.height))
                spinner.startAnimating()
                tableView.tableFooterView = spinner
                tableView.tableFooterView?.isHidden = false
            }
            self.pageControlManager.loadNextPage()
        }
    }
}
