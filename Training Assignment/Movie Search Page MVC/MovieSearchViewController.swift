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
    
    var observerID: UUID!
    var loader: Loader!
    var viewDataModel: MovieSearchViewDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchResultsTableView.dataSource = self
        self.searchResultsTableView.delegate = self
        self.movieTitleSearchBar.delegate = self
        self.loader = Loader()
        self.viewDataModel = MovieSearchViewDataModel()
        self.observerID = self.viewDataModel.subscribe(observer: self)

        // Do any additional setup after loading the view.
    }
    
//    @IBAction func searchMovieButtonTapped(_ sender: UIButton) {
//        present(loader.loadingAlert,animated: true)
//        self.viewDataModel.loadNextPage(for: self.searchTitleTextField.text ?? "")
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CheckMovieSegue" {
            if let destinationVC = segue.destination as? MovieDetailsViewController {
                if let viewData = sender as? MovieDetailsViewDataModel {
                    destinationVC.viewDataModel = viewData
                }
            }
        }
    }

}

extension MovieSearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        present(loader.loadingAlert,animated: true)
        self.viewDataModel.searchMovie(with: searchBar.text ?? "")
    }
}

extension MovieSearchViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate   {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewDataModel.getMovieCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.searchResultsTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)

        guard let cell = cell as? MoviesTableViewCell else {
            return cell
        }

        cell.cellDataModel = self.viewDataModel.getMovieInfo(ofIndex: indexPath.row)
        cell.setCellElements()

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let sender = MovieDetailsViewDataModel(info: viewDataModel.getMovieData(ofIndex: indexPath.row))
        performSegue(withIdentifier: "CheckMovieSegue", sender: sender)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: indexPath.section) - 1
        if (indexPath.row == lastRowIndex && self.viewDataModel.hasLoadablePage()) {
            let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: cell.bounds.height))
            spinner.startAnimating()
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
            self.viewDataModel.loadNextPage(for: self.movieTitleSearchBar.text ?? "")
            
        }else {
            self.searchResultsTableView.tableFooterView = nil
        }
    }
    
}

extension MovieSearchViewController: IndetifiableObserver {

    func notifyMeWhenDone() {
        DispatchQueue.main.async {
            
            self.searchResultsTableView.reloadData()
            self.loader.loadingAlert.dismiss(animated: true)
        }
    }
}
