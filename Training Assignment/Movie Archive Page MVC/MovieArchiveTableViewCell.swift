//
//  MovieArchiveTableViewCell.swift
//  Training Assignment
//
//  Created by Ayush Kumar Sinha on 23/08/23.
//
// File Responsibility - Define the Custom Cell Class, which will be coding compliant to Movie Archive Table View Cell
//      * Render Data from Model provided by View Controller *
//      * Customise Cell Elements( Interface) *
//      * Reset cell data while dequeing/reusing *

import UIKit

class MovieArchiveTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    //Dependency
    var cellDataModel: MovieArchiveCellDataModel!
    var imageLoader: ImageLoader = ImageManager.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        customizeCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCellElements(){
        self.movieTitleLabel.text = self.cellDataModel.getTitle()
        self.movieOverviewLabel.text = self.cellDataModel.getOverview()
        self.moviePosterImageView.image = imageLoader.getPlaceholderImage()
        if !self.cellDataModel.getPosterFile().isEmpty {
            imageLoader.loadImage(from: Helper.getImageUrlFrom(moviePoster: self.cellDataModel.posterImagePath)) { (image) in
                DispatchQueue.main.async {
                    self.moviePosterImageView.image = image
                }
            }
        }
    }
    
    func customizeCell(){
        let posterHeight = self.moviePosterImageView.frame.height
        let cornerRadius = posterHeight / 15
        self.moviePosterImageView.layer.cornerRadius = cornerRadius
    }
}
