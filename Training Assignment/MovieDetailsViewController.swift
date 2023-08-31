//
//  MovieDetailsViewController.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 23/08/23.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movieData: MovieDetailsViewDataModel!
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieRatingLebel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var movieOverViewLabel: UILabel!
    @IBOutlet weak var releaseDateSectionHeadLabel: UILabel!
    @IBOutlet weak var ratingSectionHeadLabel: UILabel!
    @IBOutlet weak var popularitySectionHeadLabel: UILabel!
    @IBOutlet weak var overviewSectionHeadLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        movieData.subscribe(observer: self)
        setInterface()
        setViewContent()
        
        
        // Do any additional setup after loading the view.
    }
    
    func setInterface(){
        self.releaseDateSectionHeadLabel.text = "Release Date"
        self.ratingSectionHeadLabel.text = "⭐️ Rating"
        self.popularitySectionHeadLabel.text = "❤️Popularity"
        self.overviewSectionHeadLabel.text = "Overview"
        self.moviePosterImageView.layer.cornerRadius = 20
    }
    
    func setViewContent(){
        self.title = self.movieData.movieInfo.title
        self.releaseDateLabel.text = self.movieData.movieInfo.releaseDate
        self.movieRatingLebel.text = String(self.movieData.movieInfo.rating)
        self.popularityLabel.text = String(self.movieData.movieInfo.popularity)
        self.movieOverViewLabel.text = self.movieData.movieInfo.overview
        movieData.setPoster()
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

extension MovieDetailsViewController: Observer {
    func notifyMeWhenDone() {
        self.moviePosterImageView.image = movieData.moviePoster
    }
}
