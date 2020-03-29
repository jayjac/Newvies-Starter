//
//  TVShowDetailsViewController.swift
//  Newvies
//
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit
import TMDBSwift

class TVShowDetailsViewController: UIViewController {
    
    var tvShow: TVMDB!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var adContainerView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var createdByLabel: UILabel!
    @IBOutlet var airDateLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var episodeCountLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!
    @IBOutlet var homepageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNativeAdView()
        retrieveTVShowDetails()
    }
    
    private func addNativeAdView() {
        guard !InAppManager.default.isUserPaid() else {
            adContainerView.isHidden = true
            return
        }
        if let view = Advertising.default.retrieveAdView(for: self) {
            adContainerView.addSubview(view)
            view.frame =  adContainerView.bounds
        }
    }
    
    private func retrieveTVShowDetails() {

        posterImageView.nmv_setBackdrop(show: tvShow)
        
        TVMDB.tv(tvShowID: tvShow.id, language: "en") { (cr: ClientReturn, detail: TVDetailedMDB?) in
            guard let detail = detail else { return }
            DispatchQueue.main.async {
                [weak self] in
                guard let strongSelf = self else { return }
                
                strongSelf.titleLabel.text = detail.name
                strongSelf.createdByLabel.text = "By \(detail.createdBy?.name ?? "unknown")"
                strongSelf.airDateLabel.text = "Debut " +  LabelTextFormatter.formatReleaseDate(detail.first_air_date ?? "unknown")
                strongSelf.descriptionLabel.text = detail.overview
                
                strongSelf.homepageLabel.text = detail.homepage
                strongSelf.genresLabel.nmv_setGenres(genres: detail.genres)
                
                if let episodes = detail.number_of_episodes {
                    strongSelf.episodeCountLabel.text = "Episode(s): \(episodes) | Season(s): \(detail.seasons.count)"
                }
                
            }
            
        }
        
        
        
        
    }
    


}
