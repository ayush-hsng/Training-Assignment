//
//  MovieDetailsViewController.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 23/08/23.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movieData: AppMovie!
    
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
        self.title = self.movieData.movieInfo.title
        self.releaseDateLabel.text = self.movieData.movieInfo.release_date
        self.movieRatingLebel.text = String(self.movieData.movieInfo.vote_average)
        self.popularityLabel.text = String(self.movieData.movieInfo.popularity)
        self.movieOverViewLabel.text = self.movieData.movieInfo.overview
        self.moviePosterImageView.image = self.movieData.moviePoster
        self.moviePosterImageView.layer.cornerRadius = 20
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
