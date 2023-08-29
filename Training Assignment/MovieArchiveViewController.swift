//
//  MovieArchiveViewController.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 23/08/23.
//

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
                if let movieData = sender as? AppMovie {
                    destinationVC.movieData = movieData
                }
            }
        }
    }

}

extension MovieArchiveViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewDataModel.getPopularMovieCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = archiveTableView.dequeueReusableCell(withIdentifier: "ArchiveCell", for: indexPath)
        
        guard let cell = cell as? MovieArchiveTableViewCell else {
            return cell
        }
        
        cell.setCellElements(from: viewDataModel.getPopularMovie(by: indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var poster: UIImage!
        if let cell = tableView.cellForRow(at: indexPath) as? MovieArchiveTableViewCell {
            poster = cell.moviePosterImageView.image
        }else {
            poster = ImageDataManager.shared.getPlaceholderImage()
        }
        
        let sender = AppMovie(info: viewDataModel.getPopularMovie(by: indexPath.row), poster: poster)
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
