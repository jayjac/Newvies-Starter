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
    private let semaphore = DispatchSemaphore(value: 1)
    
    init(delegate: TVShowFetcherDelegate) {
        TMDBConfig.apikey = "ea28f920c00835f2af62b6560e3c6e3a"
        self.delegate = delegate
    }
    
    func fetchLatestTVShows(page: Int) {
        TMDBConfig.apikey = Constants.TMBDKey
        let numberOfPages: Int = 4
        var tvShowsArray = [TVMDB]()
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            [weak self] in
            for i in 1...numberOfPages {
                self?.semaphore.wait()
                let subPage = (page - 1) * numberOfPages + i
                TVMDB.ontheair(page: subPage, language: "en") { (cr: ClientReturn, tvShows: [TVMDB]?) in
                    self?.semaphore.signal()
                    if let error = cr.error {
                        DispatchQueue.main.async {
                            self?.delegate?.tvShowFetcherDidFail(error: error)
                        }
                        
                        return;
                    }
                    if let shows = tvShows {
                        tvShowsArray.append(contentsOf: shows.filterIncomplete())
                    }
                }
                DispatchQueue.main.async {
                    self?.delegate?.tvShowFetcherDidLoad(tvShows: tvShowsArray)
                }
            }

        }
        

        
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
