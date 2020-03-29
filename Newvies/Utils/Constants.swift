//
//  Constants.swift
//  Newvies
//
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation


/*
 * It is good practice to put your constants away from your code.
 * That way you do not need to scour all your files to change something.
 */
struct Constants {
    
    // Provide your own Appodeal key here from the dashboard
    static let appodealKey = "<YOUR APPODEAL APP KEY>"
    
    // Provide your MovieDB API key
    // https://www.themoviedb.org/account/signup?language=en
    static let TMBDKey = "<YOUR MOVIE DB API KEY>"
    
    // Tableview Cell Reuse Identifiers
    static let movieCellIdentifier = "MovieCell"
    static let tvShowCellIdentifier = "TVShowCell"
    static let rewardedVideoAdCellIdentifier = "RewardVideoAdCell"
    
    // Appstore Connect SKU for the purchasable product
    static let noAdSKU = "Newvies.noAd"
    
    // Userdefaults Key that is set to true when the user has paid.
    static let paidUserDefaults = "Newview.PaidUser"
    
    // Likelyhood of having a popup ad. Here the user has a 1-in-4 chance of having a pop-up ad.
    // You can tweak that number if you want to see more/fewer popups.
    static let interstitialAdAverage: Int = 4

    
    static let MovieDetailsViewController = "MovieDetailsViewController"
    static let TVShowDetailsViewController = "TVShowDetailsViewController"
    static let InAppViewController = "InAppViewController"
    
    static let MAX_REVIEWS_COUNT = 6
    static let reviewSeparator = "\n\n***************************************************\n\n"

    static func smallPosterURL(_ posterPath: String) -> URL {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w780")  else {
            fatalError()
        }
        return url.appendingPathComponent(posterPath)
    }
}
