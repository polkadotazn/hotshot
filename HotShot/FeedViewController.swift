//
//  FeedViewController.swift
//  HotShot
//
//  Created by Emmanuel Feygelson on 2/20/18.
//  Copyright © 2018 Karan Cheema. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    var isHot = true
    
    
    @IBAction func hotNewSelectorChanged(_ sender: UISegmentedControl) {
        isHot = !isHot
    }
    

}
