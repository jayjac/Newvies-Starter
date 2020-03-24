//
//  InterstitialAdManager.swift
//  Newvies
//
//  Created by Jay Jac on 3/23/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Appodeal


class InterstitialAdManager {
    
    static func showInterstitialRandomly(from vc: UIViewController) -> Bool {
        let random = Int.random(in: 0...Constants.interstitialAdAverage)
        if random == 0 && Appodeal.isReadyForShow(with: .interstitial) {
            Appodeal.showAd(.interstitial, rootViewController: vc)
            return true
        }
        return false
    }
}
