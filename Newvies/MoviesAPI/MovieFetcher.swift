//
//  MovieFetcher.swift
//  Newvies
//
//  Created by Jay Jac on 3/15/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import TMDBSwift


protocol MovieFetcherDelegate: class {
    func movieFetcherDidLoad(movies: [MovieMDB])
    func movieFetcherDidFail(error: Error)
}


class MovieFetcher: Fetcher {
    
    private weak var delegate: MovieFetcherDelegate?
    
    init(delegate: MovieFetcherDelegate) {
        self.delegate = delegate
    }
    
    
    func fetchLatestMovies(page: Int = 1) {
        fetchLatest(type: .movie, page: page) {
            [weak self] (error, movies, tvShows) in
            if let error = error {
                self?.delegate?.movieFetcherDidFail(error: error)
                return
            }
            if let movies = movies {
                self?.delegate?.movieFetcherDidLoad(movies: movies)
            }
        }
    }
    
}


