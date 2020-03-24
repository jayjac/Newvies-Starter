//
//  MovieTableViewCell.swift
//  Newvies
//
//  Created by Jay Jac on 3/16/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit
import TMDBSwift


class MovieTableViewCell: UITableViewCell {

    @IBOutlet var shadowView: UIView!
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieDescription: UILabel!
    @IBOutlet var movieRating: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
    }
    
    override func awakeFromNib() {
        shadowView.layer.shadowColor = UIColor(white: 0.0, alpha: 1.0).cgColor
        shadowView.layer.shadowRadius = 6.0
        shadowView.layer.shadowOpacity = 0.4
    }
    
    private func reset() {
        movieImage.image = nil
        movieTitle.text = nil
        movieDescription.text = nil
        movieRating.text = nil
    }
    
    func setupWith(movie: MovieMDB) {
        reset()
        movieTitle.text = movie.original_title

        movieRating.nmv_setReleaseDateAndRatings(date: movie.release_date, voteAverage: movie.vote_average, voteCount: movie.vote_count)
        
        movieImage.nmv_setBackdrop(movie: movie)
        
        if let description = movie.overview {
            movieDescription.text = description
        }
    }

}
