//
//  VariantsTableViewController.swift
//  kba
//
//  Created by user909680 on 4/13/18.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class VariantsTableViewController: UITableViewController {

    var variants = [CarProperty]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sorry = NSLocalizedString("Sorry", comment: "")
        let fail = NSLocalizedString("Fail", comment: "")
        let variants = NSLocalizedString("Variants", comment: "")
        title = variants
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
            url = "https://www.regcheck.org.uk/api/kba.aspx/DE/ListVariants/" + GlobalSettings.SelectedMake + "/" + GlobalSettings.SelectedModel
        }
        
        if GlobalSettings.SelectedCountry == .Austria
        {
            // 128740
            url = "https://www.regcheck.org.uk/api/kba.aspx/AT/ListVariants/" +
                GlobalSettings.SelectedMake + "/" + GlobalSettings.SelectedModel
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
                    // Item1 - Code
                    // Item2 - Text
                    let description = subJson["Item2"].string!
                    let code = subJson["Item1"].string!
                    let carProperty = CarProperty(with: description)
                    carProperty.Value = code
                    self.variants.append(carProperty)
                }
                
                self.tableView.reloadData()
                
                callback(true)
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return variants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VariantsCell", for: indexPath)

        cell.textLabel?.text = variants[indexPath.row].Property
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        GlobalSettings.SelectedCode = variants[indexPath.row].Value
        performSegue(withIdentifier: "goToResultsFromVariants", sender: self)
    }

   
    @IBAction func searchBarButtonPressed(_ sender: UIBarButtonItem) {
        SearchHandler.Show(sender: self)
    }
    

}
