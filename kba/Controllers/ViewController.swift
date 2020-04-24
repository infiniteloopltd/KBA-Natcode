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
        self.navigationController?.navigationBar.backgroundColor = ViewController.flatMint()
    }
    
    class func flatMint() -> UIColor {
           return UIColor(red: 26/255, green: 189/255, blue: 156/255, alpha: 1)
    }

    override func viewWillAppear(_ animated: Bool) {
        
        let w = self.view.layer.bounds.width;
        let h = self.view.layer.bounds.height;
        Logging.Log(Channel: "kba", Log: "Started with \(w)x\(h)")
        
        GermanCell.MakeFunky()
        AustrianCell.MakeFunky()
        
        
        
    }
    
    func gradient(frame:CGRect) -> CAGradientLayer {
        let flatMint = UIColor(red: 26/255, green: 189/255, blue: 156/255, alpha: 1)
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        
        layer.colors = [
            UIColor.white.cgColor,flatMint.cgColor]
        return layer
    }
    
  
  

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableView.indexPathForSelectedRow?.section ?? "?")
        if (indexPath.section == 0)
        {
            GlobalSettings.SelectedCountry = .Germany
            GermanCell.accessoryType = .checkmark
            AustrianCell.accessoryType = .none
            Logging.Log(Channel: "kba", Log: "Selected Germany")
        }
        
        if (indexPath.section == 1)
        {
            GlobalSettings.SelectedCountry = .Austria
            GermanCell.accessoryType = .none
            AustrianCell.accessoryType = .checkmark
            Logging.Log(Channel: "kba", Log: "Selected Austria")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "goToMakes", sender: self)
    }
   

    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
        SearchHandler.Show(sender: self, segue: "goToResults")
    }
}

