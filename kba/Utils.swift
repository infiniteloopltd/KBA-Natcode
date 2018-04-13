//
//  Utils.swift
//  kba
//
//  Created by user909680 on 4/13/18.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit

class Utils
{
    static func ShowMessage(title: String, message : String, controller : UIViewController)
    {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        controller.present(alertController, animated: true, completion: nil)
    }
}
