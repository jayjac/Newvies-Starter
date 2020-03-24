//
//  TVShowDetailsViewController.swift
//  Newvies
//
//  Created by Jay Jac on 3/23/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit
import TMDBSwift

class TVShowDetailsViewController: UIViewController {
    
    var tvShow: TVMDB?
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var createdByLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        retrieveTVShow()
    }
    
    func retrieveTVShow() {
        guard let show = tvShow else {
            fatalError()
        }
        posterImageView.nmv_setBackdrop(show: show)
        TVMDB.tv(tvShowID: show.id, language: "en") { (cr: ClientReturn, detail: TVDetailedMDB?) in
            guard let detail = detail else { return }
            DispatchQueue.main.async {
                [weak self] in
                guard let strongSelf = self else { return }
                
                //strongSelf.titleLabel.text = detail.name
                
                //strongSelf.createdByLabel.text = detail.createdBy?.name
            }
            
        }
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
