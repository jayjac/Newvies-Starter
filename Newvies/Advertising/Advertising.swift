//
//  Advertising.swift
//  Newvies
//
//  Created by Jay Jac on 3/17/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import Appodeal

typealias RewardVideoCallback = () -> Void

class Advertising: NSObject {
    
    static let `default` = Advertising()
    private var callback: RewardVideoCallback?
    
    private override init() {
        super.init()
    }

    func initializeSDK() {
        Appodeal.setRewardedVideoDelegate(self)
        Appodeal.initialize(withApiKey: Constants.appodealKey, types: [.rewardedVideo, .nativeAd, .interstitial, .banner])
    }
    
    func addBanner(to vc: UIViewController) {
        Appodeal.showAd(.bannerBottom, rootViewController: vc)
    }
    
    
    func playRewardedVideo(from rootVC: UIViewController, callback: @escaping RewardVideoCallback) {
        self.callback = callback
        Appodeal.showAd(.rewardedVideo, rootViewController: rootVC)
    }
}


extension Advertising: AppodealRewardedVideoDelegate {
    
    func rewardedVideoWillDismissAndWasFullyWatched(_ wasFullyWatched: Bool) {
        callback?()
    }

}
