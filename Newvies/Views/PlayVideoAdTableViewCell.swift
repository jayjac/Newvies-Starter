//
//  PlayVideoAdTableViewCell.swift
//  Newvies
//
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit

class PlayVideoAdTableViewCell: UITableViewCell {
    
    var rootViewController: UIViewController?



    @IBAction func noMoreAdButtonTapped(_ sender: Any) {
        guard let rootVC = rootViewController else {
            fatalError()
        }
        InAppViewController.show(from: rootVC)
    }


}
