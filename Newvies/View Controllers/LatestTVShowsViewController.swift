//
//  LatestTVShowsViewController.swift
//  Newvies
//
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit
import TMDBSwift


class LatestTVShowsViewController: UIViewController {
    
    private var tvShowFetcher: TVShowFetcher?
    @IBOutlet var tableView: UITableView!
    private var tvShows: [TVMDB] = [TVMDB]()
    private var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tvShowFetcher = TVShowFetcher(delegate: self)
        tableView.dataSource = self
        tableView.delegate = self
        loadTVShows(reload: true)
        NotificationCenter.default.addObserver(self, selector: #selector(removeAdBanner), name: .noAdPurchase, object: nil)
    }
    
    @IBAction func plusBarButtonTapped(_ sender: Any) {
        InAppViewController.show(from: self)
    }
    
    
    private func loadTVShows(reload: Bool) {
        if reload {
            currentPage = 0
        }
        currentPage += 1
        tvShowFetcher?.fetchLatestTVShows(page: currentPage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addAdBanner()
    }
    
    private func addAdBanner() {
        if !InAppManager.default.isUserPaid() {
            Advertising.default.addBanner(to: self)
        }
    }
    
    @objc private func removeAdBanner() {
        Advertising.default.removeBanner()
    }
    
    
    

}

extension LatestTVShowsViewController: TVShowFetcherDelegate {
    func tvShowFetcherDidLoad(tvShows: [TVMDB]) {
        
        if currentPage == 1 {
            self.tvShows.removeAll()
        }
        self.tvShows.append(contentsOf: tvShows)
        self.tableView.reloadData()
    }
    
    func tvShowFetcherDidFail(error: Error) {
        
    }
    
    
}

extension LatestTVShowsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tvShowCellIdentifier) as? TVShowTableViewCell else {
            fatalError()
        }
        let index = indexPath.row
        let show = tvShows[index]
        cell.setup(with: show)
        return cell
        
    }
}

extension LatestTVShowsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if index == tvShows.count - 1 && tableView.isDragging {
            loadTVShows(reload: false)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        let show = tvShows[row]
        let showDetailsViewController = storyboard!.instantiateViewController(identifier: Constants.TVShowDetailsViewController) as! TVShowDetailsViewController
        showDetailsViewController.tvShow = show
        navigationController?.pushViewController(showDetailsViewController, animated: true)
    }
}
