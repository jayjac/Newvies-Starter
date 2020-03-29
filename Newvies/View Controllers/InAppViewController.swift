//
//  InAppViewController.swift
//  Newvies
//
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit

class InAppViewController: UIViewController {

    @IBOutlet var purchaseButton: UIButton!
    
    
    class func show(from vc: UIViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let inApp = storyboard.instantiateViewController(identifier: Constants.InAppViewController)
        vc.present(inApp, animated: true, completion: nil)
    }
    
    @IBAction func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePurchaseButton()
    }
    
    private func updatePurchaseButton() {
        guard let price = InAppManager.default.localizedPrice else {
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 5.0) {
                self.updatePurchaseButton()
            }
            return
        }
        let title = "Buy " + price
        purchaseButton.setTitle(title, for: .normal)
    }
    
    @IBAction func purchaseButtonTapped() {
        InAppManager.default.purchaseNoAdProduct()
    }
    
    @IBAction func restoreButtonTapped() {
        InAppManager.default.restorePurchases()
    }
    

}
