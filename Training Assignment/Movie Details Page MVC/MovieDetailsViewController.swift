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
        movieData.setPoster()
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
        self.title = self.movieData.getTitle()
        self.releaseDateLabel.text = self.movieData.getReleaseDate()
        self.movieRatingLebel.text = self.movieData.getRating()
        self.popularityLabel.text = self.movieData.getPopularity()
        self.movieOverViewLabel.text = self.movieData.getOverview()
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
        DispatchQueue.main.async {
            self.moviePosterImageView.image = self.movieData.moviePoster
        }
    }
}
