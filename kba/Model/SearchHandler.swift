//
//  SearchHandler.swift
//  kba
//
//  Created by user909680 on 4/19/18.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit

class SearchHandler
{
    static func Show(sender: UIViewController, segue: String)
    {
        let searchTitle = NSLocalizedString("Search", comment: "")
        let searchBy = NSLocalizedString("Search by", comment: "")
        let cancelText = NSLocalizedString("Cancel", comment: "")
        
        var code = ""
        if GlobalSettings.SelectedCountry == .Germany
        {
            code = "KBA"
        }
        if GlobalSettings.SelectedCountry == .Austria
        {
            code = "Nat Code"
        }
        
        var alertText : UITextField = UITextField()
        
        let alert = UIAlertController(title: searchBy + " " + code, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: searchTitle, style: UIAlertActionStyle.default) { (alertAction) in
            print(alertText.text!)
            GlobalSettings.SelectedCode = alertText.text!
            // Perform segue
            
            if let resultsViewController = sender as? ResultsTableViewController {
                resultsViewController.Properties.removeAll()
                resultsViewController.viewDidLoad()
            }
            else {
                sender.performSegue(withIdentifier: segue, sender: self)
            }
            
        }
        
        let cancel = UIAlertAction(title: cancelText, style: UIAlertActionStyle.cancel)
        
        alert.addTextField { (textField) in
            textField.placeholder = code
            alertText = textField
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        
    
        sender.present(alert, animated: true, completion: nil)
        
        
        
    }
}
