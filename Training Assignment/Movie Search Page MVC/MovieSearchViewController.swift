//
//  MovieSearchViewController.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 06/09/23.
//

import UIKit

class MovieSearchViewController: UIViewController {
    @IBOutlet weak var searchResultsTableView: UITableView!
    @IBOutlet weak var movieTitleSearchBar: UISearchBar!
    
    var searchResultsTableViewDataSource: UITableViewDataSource!
    var searchResultsTableViewDelegate: UITableViewDelegate!
    
    var observerID: UUID!
    var loader: Loader!
    var viewDataModel: MovieSearchViewDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.viewDataModel = MovieSearchViewDataModel()
        self.observerID = self.viewDataModel.subscribe(observer: self)
        
        self.searchResultsTableViewDelegate = MovieTableViewDelegate(viewController: self, pageControlManager: self.viewDataModel)
        self.searchResultsTableViewDataSource = MovieTableViewDataSource(viewDataModel: self.viewDataModel)
        
        self.searchResultsTableView.dataSource = self.searchResultsTableViewDataSource
        self.searchResultsTableView.delegate = self.searchResultsTableViewDelegate
        self.movieTitleSearchBar.delegate = self
        self.loader = Loader()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CheckMovieSegue" {
            if let destinationVC = segue.destination as? MovieDetailsViewController {
                if let indexPath = sender as? IndexPath {
                    destinationVC.viewDataModel = MovieDetailsViewDataModel(info: self.viewDataModel.getMovieData(ofIndex: indexPath.row))
                }
            }
        }
    }

}

extension MovieSearchViewController: UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        present(loader.loadingAlert,animated: true)
        self.viewDataModel.searchMovie(with: searchBar.text ?? "")
    }
}

extension MovieSearchViewController: Observer {

    func notifyMeWhenDone() {
        DispatchQueue.main.async {
            
            self.searchResultsTableView.reloadData()
            self.loader.loadingAlert.dismiss(animated: true)
        }
    }
}
