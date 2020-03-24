//
//  Constants.swift
//  Newvies
//
//  Created by Jay Jac on 3/16/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation


struct Constants {
    
    static let movieCellIdentifier = "MovieCell"
    static let tvShowCellIdentifier = "TVShowCell"
    static let rewardedVideoAdCellIdentifier = "RewardVideoAdCell"
    
    static let interstitialAdAverage: Int = 4
    
    static let appodealKey = "756fcf997f4728959e9d39f86eb2e4e316dd5e5c1d74bd30"
    
    static let TMBDKey = "ea28f920c00835f2af62b6560e3c6e3a"
    
    static let MovieDetailsViewController = "MovieDetailsViewController"
    static let TVShowDetailsViewController = "TVShowDetailsViewController"
    
    static let MAX_REVIEWS_COUNT = 6
    static let reviewSeparator = "\n\n***************************************************\n\n"

    static func smallPosterURL(_ posterPath: String) -> URL {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w780")  else {
            fatalError()
        }
        return url.appendingPathComponent(posterPath)
    }
}
