//
//  ViewController.swift
//  kba
//
//  Created by Fiach Reid on 12/04/2018.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  
 
    @IBOutlet weak var GermanCell: UITableViewCell!
    
    @IBOutlet weak var AustrianCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

  

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableView.indexPathForSelectedRow?.section ?? "?")
        
        if (indexPath.section == 0)
        {
            GlobalSettings.SelectedCountry = .Germany
            GermanCell.accessoryType = .checkmark
            AustrianCell.accessoryType = .none
        }
        
        if (indexPath.section == 1)
        {
            GlobalSettings.SelectedCountry = .Austria
            GermanCell.accessoryType = .none
            AustrianCell.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "goToMakes", sender: self)
    }
   

    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
    
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
            self.performSegue(withIdentifier: "goToResults", sender: self)
            
        }
        
        let cancel = UIAlertAction(title: cancelText, style: UIAlertActionStyle.cancel)
        
        alert.addTextField { (textField) in
            textField.placeholder = code
            alertText = textField
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    
    }
}

