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
    var viewDataModel: MovieSearchViewDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchResultsTableView.dataSource = self
        self.searchResultsTableView.delegate = self
        
        self.viewDataModel = MovieSearchViewDataModel()
        self.observerID = self.viewDataModel.subscribe(observer: self)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchMovieButtonTapped(_ sender: UIButton) {
        self.viewDataModel.fetchMovisWithTitle(title: self.searchTitleTextField.text ?? "")
    }
    @IBAction func gotoPrevPageButtonTapped(_ sender: UIButton) {
    }
    @IBAction func gotoNextPageButtonTapped(_ sender: UIButton) {
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
            self.searchResultsTableView.reloadData()
        }
    }
}
