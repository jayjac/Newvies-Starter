//
//  UIExtensions.swift
//  Newvies
//
//  Created by Jay Jac on 3/23/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import SDWebImage
import TMDBSwift

extension UILabel {
    
    func nmv_setReleaseDateAndRatings(date: String?, voteAverage: Double?, voteCount: Double?) {
        text = nil
        if let voteAverage = voteAverage,
            let voteCount = voteCount,
            let date = date {
            let formattedDate = LabelTextFormatter.formatReleaseDate(date)
            let voteCountInt = Int(voteCount)
            let ratingsText = voteCountInt > 0 ? "Note: \(voteAverage)/10  (\(voteCountInt) votes)" : "(No votes yet)"
            text = "Out: \(formattedDate) • \(ratingsText)"
        }
    }
}

extension UIImageView {
    func nmv_setBackdrop(movie: MovieMDB) {
        self.image = nil
        if let path = movie.backdrop_path {
            sd_setImage(with: Constants.smallPosterURL(path), completed: nil)
        }
    }
    
    func nmv_setBackdrop(show: TVMDB) {
        self.image = nil
        if let path = show.backdrop_path {
            sd_setImage(with: Constants.smallPosterURL(path), completed: nil)
            return
        }
        if let path = show.poster_path {
            sd_setImage(with: Constants.smallPosterURL(path), completed: nil)
        }
    }
    
}
