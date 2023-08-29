//
//  MovieDetailsViewController.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 23/08/23.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movie: Movie!
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieRatingLebel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var movieOverViewLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewElements()
        
        // Do any additional setup after loading the view.
    }
    
    func setViewElements(){
        self.title = movie.title
        self.releaseDateLabel.text = movie.release_date
        self.movieRatingLebel.text = String(movie.vote_average)
        self.popularityLabel.text = String(movie.popularity)
        self.movieOverViewLabel.text = movie.overview
    
        ImageDataManager.shared.getMoviePosterRequest(from: movie.poster_path) { (image) in
            DispatchQueue.main.async {
                self.moviePosterImageView.layer.cornerRadius = 20
                self.moviePosterImageView.image = image
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
