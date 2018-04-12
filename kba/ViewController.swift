//
//  ViewController.swift
//  kba
//
//  Created by Fiach Reid on 12/04/2018.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var SelectedCountry : Countries = .Germany
 
    @IBOutlet weak var GermanCell: UITableViewCell!
    
    @IBOutlet weak var AustrianCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableView.indexPathForSelectedRow?.section ?? "?")
        
        if (indexPath.section == 0)
        {
            SelectedCountry = .Germany
            GermanCell.accessoryType = .checkmark
            AustrianCell.accessoryType = .none
        }
        
        if (indexPath.section == 1)
        {
            SelectedCountry = .Austria
            GermanCell.accessoryType = .none
            AustrianCell.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
    
         var code = ""
         if SelectedCountry == .Germany
         {
            code = "KBA"
         }
         if SelectedCountry == .Austria
         {
            code = "Nat Code"
         }
    
         var alertText : UITextField = UITextField()
        
        let alert = UIAlertController(title: "Search By " + code, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Search", style: UIAlertActionStyle.default) { (alertAction) in
            print(alertText.text!)
           
            // Perform segue
            self.performSegue(withIdentifier: "goToResults", sender: self)
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        
        alert.addTextField { (textField) in
            textField.placeholder = code
            alertText = textField
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    
    }
}

