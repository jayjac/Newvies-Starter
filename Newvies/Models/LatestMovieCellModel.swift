//
//  LatestMovieCellModel.swift
//  Newvies
//
//  Copyright © 2020 Jacaria. All rights reserved.
//

import TMDBSwift

enum LatestMovieCellType {
    case movie
    case rewardedVideoAd
}

struct LatestMovieCellModel {
    let cellType: LatestMovieCellType
    let payload: MovieMDB?
}
