//
//  TestViewController.swift
//  Newvies
//
//  Created by Jay Jac on 3/17/20.
//  Copyright © 2020 Jacaria. All rights reserved.
//

import UIKit
import Player

class TestViewController: UIViewController {
    
    let player = Player()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        player.url = URL(string: "")!
        player.view.frame = self.view.bounds
        player.playFromBeginning()
        
    }
    



}
