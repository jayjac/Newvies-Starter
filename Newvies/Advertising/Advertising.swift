//
//  Advertising.swift
//  Newvies
//
//  Copyright © 2020 Jacaria. All rights reserved.
//



typealias RewardVideoCallback = () -> Void

class Advertising: NSObject {
    
    static let `default` = Advertising()
    private var callback: RewardVideoCallback?

    
    private override init() {
        super.init()
    }

    func initializeSDK() {
        /*
         * Initialize Appodeal SDK
         */
    }
    
    func retrieveAdView(for vc: UIViewController) -> UIView? {
        /*
         * Get the native ad view
         */
    }
    
    func addBanner(to vc: UIViewController) {
         /*
         * Add banner
         */
    }
    
    func removeBanner() {
        /*
         * Remove Banner when user has paid
         */
    }
    
    static func showInterstitialRandomly(from vc: UIViewController) -> Bool {
        /**
         
         */
        return false
    }
    
    
    func playRewardedVideo(from rootVC: UIViewController, callback: @escaping RewardVideoCallback) {
        /*
         * Play the ad video
         */
    }
}



