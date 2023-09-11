//
//  MovieSearchViewController.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 06/09/23.
//

import UIKit

class MovieSearchViewController: UIViewController {
    @IBOutlet weak var searchTitleTextField: UITextField!
    @IBOutlet weak var searchResultsTableView: UITableView!
    @IBOutlet weak var pageDescriptionLabel: UILabel!
    @IBOutlet weak var prevPageButton: UIButton!
    @IBOutlet weak var nextPageButton: UIButton!
    
    var observerID: UUID!
    var loader: Loader!
    var viewDataModel: MovieSearchViewDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchResultsTableView.dataSource = self
        self.searchResultsTableView.delegate = self
        
        self.loader = Loader()
        self.viewDataModel = MovieSearchViewDataModel()
        self.observerID = self.viewDataModel.subscribe(observer: self)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchMovieButtonTapped(_ sender: UIButton) {
        present(loader.loadingAlert,animated: true)
        self.viewDataModel.fetchMovisWithTitle(title: self.searchTitleTextField.text ?? "")
    }
    @IBAction func gotoPrevPageButtonTapped(_ sender: UIButton) {
        present(loader.loadingAlert,animated: true)
        self.viewDataModel.gotoPrevPage()
    }
    @IBAction func gotoNextPageButtonTapped(_ sender: UIButton) {
        present(loader.loadingAlert,animated: true)
        self.viewDataModel.gotoNextPage()
    }
    
    func scrollToTop(){
        let topRow = IndexPath(row: 0, section: 0)
        self.searchResultsTableView.scrollToRow(at: topRow,at: .top,animated: false)
    }
    
    func loadPage() {
        self.searchResultsTableView.reloadData()
        self.scrollToTop()
        self.pageDescriptionLabel.text = String(self.viewDataModel.currentPage)
        self.enablePageControllers(currentPage: self.viewDataModel.currentPage, lastPage: self.viewDataModel.lastPage)
    }
    
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
}

extension MovieSearchViewController: IndetifiableObserver {

    func notifyMeWhenDone() {
        DispatchQueue.main.async {
            
            self.loadPage()
            self.loader.loadingAlert.dismiss(animated: true)
        }
    }
}
