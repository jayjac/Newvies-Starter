//
//  SimpleAlertPopup.swift
//  Newvies
//
//  Created by Jay Jac on 3/16/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit


class SimpleAlertPopup {
    
    static func show(title: String, message: String, rootVC: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        rootVC.present(alert, animated: true, completion: nil)
    }
}
