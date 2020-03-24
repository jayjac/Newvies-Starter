//
//  LatestMovieCellModel.swift
//  Newvies
//
//  Created by Jay Jac on 3/17/20.
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
