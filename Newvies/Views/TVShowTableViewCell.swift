//
//  TVShowTableViewCell.swift
//  Newvies
//
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit
import TMDBSwift
import SDWebImage


class TVShowTableViewCell: UITableViewCell {

    @IBOutlet var tvShowTitle: UILabel!
    @IBOutlet var tvShowImage: UIImageView!
    @IBOutlet var tvShowDetails: UILabel!
    @IBOutlet var ratings: UILabel!
    
    
    private func reset() {
        tvShowTitle.text = ""
        tvShowImage.image = nil
        tvShowDetails.text = ""
        ratings.text = ""
    }
    
    func setup(with show: TVMDB) {
        reset()
        tvShowTitle.text = show.name
        tvShowDetails.text = show.overview
        displayRatings(show: show)
        
        if let path = show.poster_path {
            tvShowImage.sd_setImage(with: Constants.smallPosterURL(path), completed: nil)
        }
    }
    
    private func displayRatings(show: TVMDB) {
        if let vote = show.vote_average,
            let voteCount = show.vote_count
             {

            let voteCountInt = Int(voteCount)
            let ratingsText = voteCountInt > 0 ? "Note: \(vote)/10  (\(voteCountInt) votes)" : "(No votes yet)"
                ratings.text = ratingsText
        }
    }


}
