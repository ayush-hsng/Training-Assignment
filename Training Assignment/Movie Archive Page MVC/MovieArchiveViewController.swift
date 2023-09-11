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
    @IBOutlet weak var pageDescriptionLabel: UILabel!
    @IBOutlet weak var prevPageButton: UIButton!
    @IBOutlet weak var nextPageButton: UIButton!
    
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
    
    
    @IBAction func prevPageButtonTapped(_ sender: UIButton) {
        present(loader.loadingAlert,animated: true)
        self.disablePageControllers()
        viewDataModel.gotoPrevPage()
    }
    
    @IBAction func nextPageButtonTapped(_ sender: UIButton) {
        present(loader.loadingAlert,animated: true)
        self.disablePageControllers()
        viewDataModel.gotoNextPage()
    }
    
    func loadContent() {
        present(loader.loadingAlert,animated: true)
        self.disablePageControllers()
        self.viewDataModel.fetchPopularMovies()
    }
    
    func loadPage() {
        self.archiveTableView.reloadData()
        self.scrollToTop()
        self.pageDescriptionLabel.text = String(self.viewDataModel.currentPage)
        self.enablePageControllers(currentPage: self.viewDataModel.currentPage, lastPage: self.viewDataModel.lastPage)
    }
    
    func scrollToTop(){
        let topRow = IndexPath(row: 0, section: 0)
        self.archiveTableView.scrollToRow(at: topRow,at: .top,animated: false)
    }
    
    // Page Control Methods
    
    func disablePageControllers(){
        self.pageDescriptionLabel.text = ""
        prevPageButton.isEnabled = false
        nextPageButton.isEnabled = false
    }
    
    func enablePageControllers(currentPage: Int, lastPage: Int){
        if currentPage > 1 {
            prevPageButton.isEnabled = true
        }
        if currentPage < lastPage {
            nextPageButton.isEnabled = true
        }
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
}

extension MovieArchiveViewController: IndetifiableObserver {
    
    func notifyMeWhenDone() {
        DispatchQueue.main.async {
            
            self.loadPage()
            
            self.loader.loadingAlert.dismiss(animated: true)
        }
    }
}
