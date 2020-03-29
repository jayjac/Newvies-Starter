//
//  UIExtensions.swift
//  Newvies
//
//  Copyright © 2020 Jacaria. All rights reserved.
//

import SDWebImage
import TMDBSwift

/*
 * This file just adds come extensions to UILabel and UIImageView to help display repetitive content
 */

extension UILabel {
    
    func nmv_setReleaseDateAndRatings(date: String?, voteAverage: Double?, voteCount: Double?) {
        text = nil
        if let voteAverage = voteAverage,
            let voteCount = voteCount,
            let date = date {
            let formattedDate = LabelTextFormatter.formatReleaseDate(date)
            let formattedVoteCount = LabelTextFormatter.formatVoteCount(Int(voteCount))
            let ratingsText = voteCount > 0 ? "Note: \(voteAverage)/10  (\(formattedVoteCount) votes)" : "(No votes yet)"
            text = "Out: \(formattedDate) • \(ratingsText)"
        }
    }
    
    
    func nmv_setGenres(genres: [MovieMDB.genresType]) {
        var genreText = ""
        for genre in genres {
            if let name = genre.name {
                genreText += "  \(name)  "
            }
        }
        text = genreText
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
