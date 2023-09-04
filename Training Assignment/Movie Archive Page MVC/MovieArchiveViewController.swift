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
    @IBOutlet weak var pageDescriptionLabel: UILabel!
    @IBOutlet weak var prevPageButton: UIButton!
    @IBOutlet weak var nextPageButton: UIButton!
    
    var viewDataModel : MovieArchiveViewDataModel!
    var observerID: UUID!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.disablePagination()
        self.archiveTableView.delegate = self
        self.archiveTableView.dataSource = self
        
        self.viewDataModel = MovieArchiveViewDataModel()
        self.observerID = self.viewDataModel.subscribe(observer: self)
        self.viewDataModel.fetchPopularMovies()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func prevPageButtonTapped(_ sender: UIButton) {
        disablePagination()
        viewDataModel.gotoPrevPage()
    }
    
    @IBAction func nextPageButtonTapped(_ sender: UIButton) {
        disablePagination()
        viewDataModel.gotoNextPage()
    }
    
    func disablePagination(){
        prevPageButton.isEnabled = false
        nextPageButton.isEnabled = false
    }
    
    func handlePagination(currentPage: Int, lastPage: Int){
        self.pageDescriptionLabel.text = String(currentPage)
        if currentPage > 1 {
            prevPageButton.isEnabled = true
        }
        if currentPage < lastPage {
            nextPageButton.isEnabled = true
        }
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

extension MovieArchiveViewController: IndetifiableObserver {
    
    func notifyMeWhenDone() {
        DispatchQueue.main.async {
            self.archiveTableView.reloadData()
            self.pageDescriptionLabel.text = String(self.viewDataModel.currentPage)
            self.handlePagination(currentPage: self.viewDataModel.currentPage, lastPage: self.viewDataModel.lastPage)
        }
    }
}
