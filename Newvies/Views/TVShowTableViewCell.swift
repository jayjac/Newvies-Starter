//
//  TVShowTableViewCell.swift
//  Newvies
//
//  Created by Jay Jac on 3/16/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit
import TMDBSwift
import SDWebImage


class TVShowTableViewCell: UITableViewCell {

    @IBOutlet var tvShowTitle: UILabel!
    @IBOutlet var tvShowImage: UIImageView!
    
    private func reset() {
        tvShowTitle.text = ""
        tvShowImage.image = nil
    }
    
    func setup(with show: TVMDB) {
        reset()
        tvShowTitle.text = show.name
        
        if let path = show.poster_path {
            tvShowImage.sd_setImage(with: Constants.smallPosterURL(path), completed: nil)
        }
    }


}
