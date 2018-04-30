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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
