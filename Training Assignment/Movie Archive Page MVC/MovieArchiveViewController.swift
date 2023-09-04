//
//  MovieArchiveViewController.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 23/08/23.
//
// File Responsibility - Define View Controller for Movie Archive Page
//      * store a view data model for page view *
//      * act as observer of model status( implement Observer protocol)  *
//      * render the data onto view page( act as data Source for table view) *
//      * act as delegate of table view to handle cell selection events *

import UIKit

class MovieArchiveViewController: UIViewController {
    
    @IBOutlet weak var archiveTableView: UITableView!
    
    var viewDataModel : MovieArchiveViewDataModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.archiveTableView.delegate = self
        self.archiveTableView.dataSource = self
        
        viewDataModel = MovieArchiveViewDataModel()
        viewDataModel.subscribe(observer: self)
        viewDataModel.fetchPopularMovies()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CheckMovieSegue" {
            if let destinationVC = segue.destination as? MovieDetailsViewController {
                if let viewData = sender as? MovieDetailsViewDataModel {
                    destinationVC.movieData = viewData
                }
            }
        }
    }

}

extension MovieArchiveViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewDataModel.getMovieCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = archiveTableView.dequeueReusableCell(withIdentifier: "ArchiveCell", for: indexPath)
        
        guard let cell = cell as? MovieArchiveTableViewCell else {
            return cell
        }
        
        cell.cellDataModel = viewDataModel.getMovieInfo(ofIndex: indexPath.row)
        
        cell.setCellElements()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sender = MovieDetailsViewDataModel(info: viewDataModel.getMovieData(ofIndex: indexPath.row))
        performSegue(withIdentifier: "CheckMovieSegue", sender: sender)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MovieArchiveViewController: Observer {
    func notifyMeWhenDone() {
        DispatchQueue.main.async {
            self.archiveTableView.reloadData()
        }
    }
}
