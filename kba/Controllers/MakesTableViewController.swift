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
    
    var filteredMakes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let sorry = NSLocalizedString("Sorry", comment: "")
        let fail = NSLocalizedString("Fail", comment: "")
        let makes = NSLocalizedString("Makes", comment: "")
        title = makes
        SVProgressHUD.show()
        CallWebservice(){ success in
            SVProgressHUD.dismiss()
            if !success
            {
                Utils.ShowMessage(title: sorry, message: fail, controller: self)
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
        Logging.Log(Channel: "kba", Log: url)
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
                self.filteredMakes = self.makes
                self.tableView.reloadData()
                
                callback(true)
        }
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredMakes.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MakesCell", for: indexPath)

        cell.textLabel?.text = filteredMakes[indexPath.row]
        cell.MakeFunky()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        GlobalSettings.SelectedMake = filteredMakes[indexPath.row].addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        performSegue(withIdentifier: "goToModels", sender: self)
    }


    @IBAction func searchBarButtonPressed(_ sender: UIBarButtonItem) {
        SearchHandler.Show(sender: self, segue: "goToResultsFromMakes")
    }
    
}

extension MakesTableViewController: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text != nil && searchBar.text == ""
        {
            filteredMakes = makes
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        else
        {
            filteredMakes = makes.filter {
                $0.lowercased().contains(searchBar.text!.lowercased())
            }
        }
        tableView.reloadData()
    }
}
