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
    
    var archiveTableViewDataSource: UITableViewDataSource!
    var archiveTableViewDelegate: UITableViewDelegate!
    
    var observerID: UUID!
    var loader: Loader!
    var viewDataModel : MovieArchiveViewDataModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        self.viewDataModel = MovieArchiveViewDataModel()
        self.observerID = self.viewDataModel.subscribe(observer: self)
        
        self.archiveTableViewDelegate = MovieTableViewDelegate(viewController: self,pageControlManager: viewDataModel)
        self.archiveTableViewDataSource = MovieTableViewDataSource(viewDataModel: self.viewDataModel)
        
        self.archiveTableView.delegate = self.archiveTableViewDelegate
        self.archiveTableView.dataSource = self.archiveTableViewDataSource
        
        // Instantiating compositions
        self.loader = Loader()
        
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
                if let indexPath = sender as? IndexPath {
                    destinationVC.viewDataModel = MovieDetailsViewDataModel(info: self.viewDataModel.getMovieData(ofIndex: indexPath.row))
                }
            }
        }
    }
    
    

}

extension MovieArchiveViewController: Observer {
    
    func notifyMeWhenDone() {
        DispatchQueue.main.async {
            
            self.archiveTableView.reloadData()
            
            self.loader.loadingAlert.dismiss(animated: true)
        }
    }
}
