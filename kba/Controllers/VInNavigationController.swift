//
//  VInNavigationController.swift
//  kba
//
//  Created by Fiach Reid on 30/04/2018.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit

class VInNavigationController: UINavigationController {

    @IBOutlet weak var tabButton: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let vinText = NSLocalizedString("VIN", comment: "")
        tabButton.title = vinText
    }

}
