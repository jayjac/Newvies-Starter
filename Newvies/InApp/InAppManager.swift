//
//  InAppManager.swift
//  Newvies
//
//  Copyright © 2020 Jacaria. All rights reserved.
//

import StoreKit

extension Notification.Name {
    static let noAdPurchase = Notification.Name(rawValue: "Newvies.noAdPurchase")
}

class InAppManager: NSObject {
    
    
    static let `default` =  InAppManager()
    private(set) var noAdProduct: SKProduct?
    private lazy var productRequest: SKProductsRequest = {
        var identifiers: Set<String> = Set()
        identifiers.insert(Constants.noAdSKU)
        let productRequest = SKProductsRequest(productIdentifiers: identifiers)
        return productRequest
    }()
    
    
    var localizedPrice: String? {
        guard let product = noAdProduct else {
            return nil
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = product.priceLocale
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: product.price)
    }
    
    
    private override init() {
        super.init()
    }
    
    func initialize() {
        /*
         * Listen to the transaction queue as soon as possible after app launch.
         * Let's request the one product from Apple's server so we're ready when the user
         * asks for it.
         */
    }
    
    private func markUserAsPaid() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: Constants.paidUserDefaults)
    }
    
    /*
     * Function that returns whether the user has paid the "No Advertising" one-time product
     */
    func isUserPaid() -> Bool {
        let userDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: Constants.paidUserDefaults)
    }
    
    func purchaseNoAdProduct() {
        /*
         * Do the actual purchase
         */
    }
    
    
    func restorePurchases() {
        /*
         * You must provide a way for the user to restore their previous transactions (for example on another device) in case they do not get automatically transferred over.
         */
    }
    
}




