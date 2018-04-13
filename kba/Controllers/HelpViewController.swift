//
//  HelpViewController.swift
//  kba
//
//  Created by user909680 on 4/13/18.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func kbaButtonPressed(_ sender: UIButton) {
        let url = URL(string: "http://www.kbaapi.de")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func natCodeButtonPressed(_ sender: UIButton) {
        let url = URL(string: "http://www.natcode.at")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
  

}
