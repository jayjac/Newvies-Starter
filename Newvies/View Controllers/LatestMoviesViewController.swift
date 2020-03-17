//
//  ViewController.swift
//  Newvies
//
//  Created by Jay Jac on 3/15/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit
import TMDBSwift

class LatestMoviesViewController: UIViewController {
    
    private var movieFetcher: MovieFetcher?
    @IBOutlet var tableView: UITableView!
    private var movies: [MovieMDB] = [MovieMDB]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieFetcher = MovieFetcher(delegate: self)
        tableView.dataSource = self
        tableView.delegate = self
        movieFetcher?.fetchLatestMovies()
    }

}

extension LatestMoviesViewController: MovieFetcherDelegate {
    func movieFetcherDidLoad(movies: [MovieMDB]) {
        self.movies = movies
        tableView.reloadData()
    }
    
    func movieFetcherDidFail(error: Error) {
        SimpleAlertPopup.show(title: "Error",
                              message: "Could not load movies",
                              rootVC: self)
    }
    
}


extension LatestMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.movieCellIdentifier) as? MovieTableViewCell else {
            fatalError()
        }
        let index = indexPath.row
        let movie = movies[index]
        cell.setupWith(movie: movie)
        return cell
    }
}

extension LatestMoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
