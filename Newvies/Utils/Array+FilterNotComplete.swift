//
//  Array+FilterNotEmpty.swift
//  Newvies
//
//  Created by Jay Jac on 3/23/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Foundation
import TMDBSwift


protocol MovieOrTVShow {
    var overview: String? { get }
    var poster_path: String? { get }
    var vote_count: Double? { get }
    var vote_average: Double? { get }
}

extension MovieMDB: MovieOrTVShow {}
extension TVMDB: MovieOrTVShow {}

extension Array where Element: MovieOrTVShow {
    
    func filterIncomplete() -> Self {
        return self.filter({ (movie: MovieOrTVShow) -> Bool in
            guard let overview = movie.overview, let posterPath = movie.poster_path, let voteCount = movie.vote_count, let voteAverage = movie.vote_average else {
                return false
            }
            return !overview.isEmpty && !posterPath.isEmpty && voteCount > 0 && voteAverage > 5.0
        })
    }
   
}
