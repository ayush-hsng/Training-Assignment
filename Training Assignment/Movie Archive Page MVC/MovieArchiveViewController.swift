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

class MovieArchiveViewController: UIViewController{
    
    @IBOutlet weak var archiveTableView: UITableView!
    
    // Compositions
    var observerID: UUID!
    var loader: Loader!
    var viewDataModel : MovieArchiveViewDataModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        self.archiveTableView.delegate = self
        self.archiveTableView.dataSource = self
        
        // Instantiating compositions
        self.loader = Loader()
        self.viewDataModel = MovieArchiveViewDataModel()
        self.observerID = self.viewDataModel.subscribe(observer: self)
        
        self.loadContent()
    }
    
    //Action Outlets
    func loadContent() {
        present(loader.loadingAlert,animated: true)
        self.viewDataModel.loadNextPage()
    }
    
    //Segue Method
    
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

extension MovieArchiveViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate   {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewDataModel.getMovieCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = archiveTableView.dequeueReusableCell(withIdentifier: "ArchiveCell", for: indexPath)
        
        guard let cell = cell as? MoviesTableViewCell else {
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = self.archiveTableView.numberOfRows(inSection: indexPath.section) - 1
        if indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: cell.bounds.height))
            spinner.startAnimating()
            self.archiveTableView.tableFooterView = spinner
            self.archiveTableView.tableFooterView?.isHidden = false
            self.viewDataModel.loadNextPage()
        }
    }
    
}

extension MovieArchiveViewController: IndetifiableObserver {
    
    func notifyMeWhenDone() {
        DispatchQueue.main.async {
            
            self.archiveTableView.reloadData()
            
            self.loader.loadingAlert.dismiss(animated: true)
        }
    }
}
