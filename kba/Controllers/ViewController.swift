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
        SearchHandler.Show(sender: self, segue: "goToResults")
    }
}

