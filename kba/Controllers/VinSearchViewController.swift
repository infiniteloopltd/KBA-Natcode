//
//  VinSearchViewController.swift
//  kba
//
//  Created by user909680 on 4/30/18.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit

class VinSearchViewController: UIViewController {

    @IBOutlet weak var tabButton: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vinText = NSLocalizedString("VIN", comment: "")
        tabButton.title = vinText
       
    }



}
