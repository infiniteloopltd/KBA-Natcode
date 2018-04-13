//
//  MakesTableViewController.swift
//  kba
//
//  Created by user909680 on 4/13/18.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class MakesTableViewController: UITableViewController {

    var makes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SVProgressHUD.show()
        CallWebservice(){ success in
            SVProgressHUD.dismiss()
            if !success
            {
                Utils.ShowMessage(title: "Sorry", message: "Failed to find any data", controller: self)
            }
        }
     
    }

    func CallWebservice(callback: @escaping (Bool) -> Void)
    {
        var url = ""
        
        if GlobalSettings.SelectedCountry == .Germany
        {
            // Sample 0005/ALQ
            url = "https://www.regcheck.org.uk/api/kba.aspx/DE/ListOfMakes"
        }
        
        if GlobalSettings.SelectedCountry == .Austria
        {
            // 128740
            url = "https://www.regcheck.org.uk/api/kba.aspx/AT/ListOfMakes"
        }
        Alamofire.request(url, method: .get)
            .responseJSON {
                response in               
              
                
                print("got Data back")
                if (response.result.value == nil)
                {
                    callback(false)
                    return
                }
                let codeJson : JSON = JSON (response.result.value!)
                print(codeJson)
                
                for (_, subJson) in codeJson {
                    self.makes.append(subJson.string!)
                }
                
                self.tableView.reloadData()
                
                callback(true)
        }
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return makes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MakesCell", for: indexPath)

        cell.textLabel?.text = makes[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        GlobalSettings.SelectedMake = makes[indexPath.row].addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        performSegue(withIdentifier: "goToModels", sender: self)
    }


   

   


}
