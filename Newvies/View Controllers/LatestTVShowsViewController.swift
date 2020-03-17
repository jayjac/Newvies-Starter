//
//  LatestTVShowsViewController.swift
//  Newvies
//
//  Created by Jay Jac on 3/16/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit
import TMDBSwift


class LatestTVShowsViewController: UIViewController {
    
    private var tvShowFetcher: TVShowFetcher?
    @IBOutlet var tableView: UITableView!
    private var tvShows: [TVMDB] = [TVMDB]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tvShowFetcher = TVShowFetcher(delegate: self)
        tableView.dataSource = self
        tvShowFetcher?.fetchLatestTVShows()

    }
    

}

extension LatestTVShowsViewController: TVShowFetcherDelegate {
    func tvShowFetcherDidLoad(tvShows: [TVMDB]) {
        self.tvShows = tvShows
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
