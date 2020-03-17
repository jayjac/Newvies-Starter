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

    static func smallPosterURL(_ posterPath: String) -> URL {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w342")  else {
            fatalError()
        }
        return url.appendingPathComponent(posterPath)
    }
}
