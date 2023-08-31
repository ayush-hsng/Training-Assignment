//
//  MovieArchiveTableViewCell.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 23/08/23.
//

import UIKit

class MovieArchiveTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    func setCellElements(from movie: Movie){
        movieTitleLabel.text = movie.title
        movieOverviewLabel.text = movie.overview
        moviePosterImageView.image = DataManager.shared.getPlaceholderImage()
        DataManager.shared.getMoviePosterRequest(from: movie.posterImagePath) { (image) in
            DispatchQueue.main.async {
                self.moviePosterImageView.image = image
            }
        }
    }
    
    func customizeCell(){
        let posterHeight = self.moviePosterImageView.frame.height
        let cornerRadius = posterHeight / 15
        self.moviePosterImageView.layer.cornerRadius = cornerRadius
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        customizeCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}