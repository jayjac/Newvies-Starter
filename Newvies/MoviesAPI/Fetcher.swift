//
//  Fetcher.swift
//  Newvies
//
//  Created by Jay Jac on 3/16/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import TMDBSwift

typealias FetchCallback = (Error?, [MovieMDB]?, [TVMDB]?) -> Void

class Fetcher {
    
    private let semaphore = DispatchSemaphore(value: 1)
    
    
    func fetchLatest(type: DiscoverType, page: Int = 1, callback: @escaping FetchCallback) {
        TMDBConfig.apikey = "ea28f920c00835f2af62b6560e3c6e3a"
        let numberOfPages: Int = 6
        var movies = [MovieMDB]()
        var tvShows = [TVMDB]()
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            [weak self] in
            for i in 1...numberOfPages {
                self?.semaphore.wait()
                let subPage = (page - 1) * numberOfPages
                let params: [DiscoverParam] = [.language("en"),
                                               .include_video(true),
                                               .page(subPage + i),
                                               .sort_by("popularity.desc")]
                DiscoverMDB.discover(discoverType: type,
                                     params: params) { (clientReturn: ClientReturn, moviesArray: [MovieMDB]?, tvShowsArray: [TVMDB]?) in
                                        self?.semaphore.signal()
                                        
                    if let error = clientReturn.error {
                        callback(error, nil, nil)
                        return
                    }
                                        if let moviesArray = moviesArray {
                                            movies.append(contentsOf: moviesArray)
                                        }
                                        if let tvShowsArray = tvShowsArray {
                                            tvShows.append(contentsOf: tvShowsArray)
                                        }
                    
                }
            }
            self?.semaphore.wait()
            DispatchQueue.main.async {
                callback(nil, movies, tvShows)
            }

        }


    }
    
    
}
