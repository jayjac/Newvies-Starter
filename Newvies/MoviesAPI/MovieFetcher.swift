//
//  MovieFetcher.swift
//  Newvies
//
//  Copyright © 2020 Jacaria. All rights reserved.
//

import TMDBSwift


protocol MovieFetcherDelegate: class {
    func movieFetcherDidLoad(movies: [MovieMDB])
    func movieFetcherDidFail(error: Error)
}


class MovieFetcher {
    
    private weak var delegate: MovieFetcherDelegate?
    private let semaphore = DispatchSemaphore(value: 1)
    
    init(delegate: MovieFetcherDelegate) {
        self.delegate = delegate
    }
    
    
    func fetchLatestMovies(page: Int) {
        TMDBConfig.apikey = Constants.TMBDKey
        let numberOfPages: Int = 4
        var moviesArray = [MovieMDB]()
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            [weak self] in
            for i in 1...numberOfPages {
                self?.semaphore.wait()
                let subPage = (page - 1) * numberOfPages + i
                MovieMDB.upcoming(page: subPage, language: "en") { (cr: ClientReturn, movies: [MovieMDB]?) in
                    self?.semaphore.signal()
                    if let error = cr.error {
                        self?.delegate?.movieFetcherDidFail(error: error)
                        return
                    }
                    if let movies = movies {
                        moviesArray.append(contentsOf: movies.filterIncomplete())
                    }
                }
            }
            DispatchQueue.main.async {
                self?.delegate?.movieFetcherDidLoad(movies: moviesArray.shuffled())
            }
        }


    }
    
}


