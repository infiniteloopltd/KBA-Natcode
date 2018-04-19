//
//  ModelsTableViewController.swift
//  kba
//
//  Created by user909680 on 4/13/18.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class ModelsTableViewController: UITableViewController {

    var models = [String]()
    var filteredModels = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sorry = NSLocalizedString("Sorry", comment: "")
        let fail = NSLocalizedString("Fail", comment: "")
        let models = NSLocalizedString("Models", comment: "")
        title = models
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
            url = "https://www.regcheck.org.uk/api/kba.aspx/DE/ListOfModels/" + GlobalSettings.SelectedMake
        }
        
        if GlobalSettings.SelectedCountry == .Austria
        {
            // 128740
            url = "https://www.regcheck.org.uk/api/kba.aspx/AT/ListOfModels/" +
                GlobalSettings.SelectedMake
        }
        print(url)
        Alamofire.request(url , method: .get)
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
                    self.models.append(subJson.string!)
                }
                
                self.filteredModels = self.models
                self.tableView.reloadData()
                
                callback(true)
        }
    }
        

   

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredModels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ModelsCell", for: indexPath)

        cell.textLabel?.text = filteredModels[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        GlobalSettings.SelectedModel = filteredModels[indexPath.row].addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        performSegue(withIdentifier: "goToVariants", sender: self)
    }

   
    @IBAction func searchBarButtonPressed(_ sender: UIBarButtonItem) {
        SearchHandler.Show(sender: self, segue: "goToResultsFromModels")
    }

}

extension ModelsTableViewController: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text != nil && searchBar.text == ""
        {
            filteredModels = models
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        else
        {
            filteredModels = models.filter {
                $0.lowercased().contains(searchBar.text!.lowercased())
            }
        }
        tableView.reloadData()
    }
}
