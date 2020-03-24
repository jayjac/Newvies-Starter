//
//  MovieDetailsViewController.swift
//  Newvies
//
//  Created by Jay Jac on 3/16/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit
import TMDBSwift
import SDWebImage
import SafariServices

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet var movieBackdropImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var homepageLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var tagLineLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!
    @IBOutlet var reviewsLabel: UILabel!
    private var homePageURL: URL?
    private var alreadyDisplayedAd: Bool = false
    
    
    var movie: MovieMDB?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        retrieveMovieDetails()
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !alreadyDisplayedAd {
            alreadyDisplayedAd = InterstitialAdManager.showInterstitialRandomly(from: self)
        }
    }
    
    func retrieveMovieDetails() {
        guard let movie = movie else {
            fatalError()
        }
        MovieMDB.movie(movieID: movie.id) { (cr: ClientReturn, md: MovieDetailedMDB?) in
            guard let detail = md else { return }
            DispatchQueue.main.async {
                [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.fillDetails(detail)
            }
        }
        
        MovieMDB.reviews(movieID: movie.id, page: 1) { (cr: ClientReturn, reviews: [MovieReviewsMDB]?) in
            
            DispatchQueue.main.async {
                [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.fillReviews(reviews: reviews)
            }

        }
    }
    
    @objc private func openWebPage() {
        guard let homepage = homePageURL else { return }
        let safari = SFSafariViewController(url: homepage)
        present(safari, animated: true, completion: nil)
    }
    
    func fillDetails(_ details: MovieDetailedMDB) {
        
        titleLabel.text = movie?.original_title
        tagLineLabel.text = details.tagline
        if let homepage = details.homepage {
            homepageLabel.text = homepage
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openWebPage))
            self.homePageURL = URL(string: homepage)
            homepageLabel.addGestureRecognizer(tapGesture)
                
        }
        if let runtime = details.runtime {
            runtimeLabel.text = "Runtime: \(runtime) minutes"
        }
        descriptionLabel.text = details.overview
        releaseDateLabel.nmv_setReleaseDateAndRatings(date: movie?.release_date, voteAverage: movie?.vote_average, voteCount: movie?.vote_count)

        var genreText = ""
        for genre in details.genres {
            if let name = genre.name {
                genreText += "  \(name)  "
            }
        }
        genresLabel.text = genreText
        
    }
    
    func fillReviews(reviews: [MovieReviewsMDB]?) {
        guard let reviews = reviews else {
            reviewsLabel.text = "No reviews"
            return
        }
        var reviewsText = ""
        for (index, rev) in reviews.enumerated() {
            if index > Constants.MAX_REVIEWS_COUNT - 1 {
                break
            }
            guard let author = rev.author, let content = rev.content else { continue }
            if index > 0 {
                reviewsText += Constants.reviewSeparator
            }
            reviewsText += "\(author): \(content)"
            
        }
        print(reviewsText)
        reviewsLabel.text = reviewsText
    }
    
    func setupUI() {
        guard let movie = movie else {
            fatalError()
        }
        movieBackdropImage.nmv_setBackdrop(movie: movie)
    }



}


