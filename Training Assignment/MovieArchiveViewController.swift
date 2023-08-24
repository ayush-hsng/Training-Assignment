//
//  MovieArchiveViewController.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 23/08/23.
//

import UIKit

class MovieArchiveViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var archiveTableView: UITableView!
    
    var moviesArchive:[Movie] = [Movie]()
    var selectedRow: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.archiveTableView.delegate = self
        self.archiveTableView.dataSource = self
        
        
        DataManager.getPopularMoviesRequest { (movieList) in
            
            DispatchQueue.main.async {
                
                if let movieList = movieList {
                    self.moviesArchive = movieList
                    self.archiveTableView.reloadData()
                }
                
            }
        }

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArchive.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = archiveTableView.dequeueReusableCell(withIdentifier: "ArchiveCell", for: indexPath)
        
        guard let cell = cell as? MovieArchiveTableViewCell else {
            return cell
        }
        
        cell.movieTitleLabel.text = moviesArchive[indexPath.row].title
        cell.movieOverviewLabel.text = moviesArchive[indexPath.row].overview
        
        DataManager.getMoviePosterRequest(from: moviesArchive[indexPath.row].poster_path) { (image) in
            
            DispatchQueue.main.async {
                cell.moviePosterImageView.layer.cornerRadius = 8
                if let image = image {
                    cell.moviePosterImageView.image = image
                }else {
                    let defaultImageName = "photo"
                    let defaultImage = UIImage(systemName: defaultImageName)
                    cell.moviePosterImageView.image = defaultImage
                }
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "CheckMovieSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CheckMovieSegue" {
                if let destinationVC = segue.destination as? MovieDetailsViewController {
                    destinationVC.movie = moviesArchive[selectedRow]
                }
            }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
