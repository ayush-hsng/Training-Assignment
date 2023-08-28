//
//  MovieArchiveViewController.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 23/08/23.
//

import UIKit

class MovieArchiveViewController: UIViewController {
    
    @IBOutlet weak var archiveTableView: UITableView!
    
    var moviesArchive:[Movie] = [Movie]()
    var selectedRow: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.archiveTableView.delegate = self
        self.archiveTableView.dataSource = self
        
        
        JsonDataManager.shared.getPopularMoviesRequest { (movieList) in
            DispatchQueue.main.async {
                if let movieList = movieList {
                    self.moviesArchive = movieList
                    self.archiveTableView.reloadData()
                }
            }
        }

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CheckMovieSegue" {
                if let destinationVC = segue.destination as? MovieDetailsViewController {
                    destinationVC.movie = moviesArchive[selectedRow]
                }
            }
    }

}

extension MovieArchiveViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArchive.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = archiveTableView.dequeueReusableCell(withIdentifier: "ArchiveCell", for: indexPath)
        
        guard let cell = cell as? MovieArchiveTableViewCell else {
            return cell
        }
        
        cell.setCellElements(from: moviesArchive[indexPath.row])
        cell.customizeCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "CheckMovieSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
