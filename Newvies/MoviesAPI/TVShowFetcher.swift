//
//  TVShowFetcher.swift
//  Newvies
//
//  Created by Jay Jac on 3/16/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import TMDBSwift


protocol TVShowFetcherDelegate: class {
    func tvShowFetcherDidLoad(tvShows: [TVMDB])
    func tvShowFetcherDidFail(error: Error)
}

class TVShowFetcher: Fetcher {
    
    private weak var delegate: TVShowFetcherDelegate?
    
    init(delegate: TVShowFetcherDelegate) {
        TMDBConfig.apikey = "ea28f920c00835f2af62b6560e3c6e3a"
        self.delegate = delegate
    }
    
    func fetchLatestTVShows(page: Int = 1) {
        fetchLatest(type: .tv, page: page) { [unowned self] (error, movies, tvShows) in
            if let error = error {
                self.delegate?.tvShowFetcherDidFail(error: error)
                return
            }
            if let tvShows = tvShows {
                self.delegate?.tvShowFetcherDidLoad(tvShows: tvShows)
                return
            }
        }
    }
    
}
