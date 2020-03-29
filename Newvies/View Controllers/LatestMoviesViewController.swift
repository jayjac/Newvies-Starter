//
//  ViewController.swift
//  Newvies
//
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit
import TMDBSwift

class LatestMoviesViewController: UIViewController {
    
    private var movieFetcher: MovieFetcher?
    @IBOutlet var tableView: UITableView!
    private var currentPage: Int = 0
    private var isPaidUser: Bool = false
    private let refreshControl = UIRefreshControl()

    private var movieCellModelArray: [LatestMovieCellModel] = [LatestMovieCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieFetcher = MovieFetcher(delegate: self)
        setupTableView()
        loadMovies(reload: true)
        NotificationCenter.default.addObserver(self, selector: #selector(userJustPaid), name: .noAdPurchase, object: nil)
        
    }
    
    @IBAction func plusBarButtonTapped(_ sender: Any) {
        InAppViewController.show(from: self)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func pullToRefresh() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2.0) {
            self.loadMovies(reload: true)
        }
    }
    
    @objc func userJustPaid() {
        loadMovies(reload: false)
    }
    
    @objc func loadMovies(reload: Bool) {
        isPaidUser = InAppManager.default.isUserPaid()
        if reload {
            currentPage = 0
        }
        currentPage += 1
        movieFetcher?.fetchLatestMovies(page: currentPage)
    }

}



extension LatestMoviesViewController: MovieFetcherDelegate {
    func movieFetcherDidLoad(movies: [MovieMDB]) {
        refreshControl.endRefreshing()
        if currentPage == 1 {
            movieCellModelArray.removeAll()
        }
        if let last = movieCellModelArray.last, last.cellType == .rewardedVideoAd {
            _ = movieCellModelArray.popLast()
        }
        movieCellModelArray.append(contentsOf: movies.map({ LatestMovieCellModel(cellType: .movie, payload: $0) }))
        
        if !isPaidUser {
            let adCell = LatestMovieCellModel(cellType: .rewardedVideoAd, payload: nil)
            movieCellModelArray.append(adCell)
        }
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
        return movieCellModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let index = indexPath.row
        let movieModel = movieCellModelArray[index]
        switch movieModel.cellType {
        case .movie:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.movieCellIdentifier) as? MovieTableViewCell else {
            fatalError()
        }
            cell.setupWith(movie: movieModel.payload!)
            return cell
            
        case .rewardedVideoAd:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.rewardedVideoAdCellIdentifier) as? PlayVideoAdTableViewCell else {
                fatalError()
            }
            cell.rootViewController = self
            return cell
        }
        
    }
}

extension LatestMoviesViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        /*
         * If this is the last row and the user is premium
         */
        if isPaidUser && tableView.isDragging && row == movieCellModelArray.count - 1 {
            loadMovies(reload: false)
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let model = movieCellModelArray[index]
        tableView.deselectRow(at: indexPath, animated: true)
        switch model.cellType {
        case .rewardedVideoAd:
            Advertising.default.playRewardedVideo(from: self) {
                self.loadMovies(reload: false)
            }
            
        case .movie:
            let movie = model.payload!
            
            let viewController = storyboard!.instantiateViewController(identifier: Constants.MovieDetailsViewController) as! MovieDetailsViewController
            viewController.movie = movie
            if let navigationController = navigationController {
                navigationController.pushViewController(viewController, animated: true)

            }

        }

    }
    
    

    
}
