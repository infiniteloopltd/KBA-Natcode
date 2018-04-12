//
//  ResultsTableViewController.swift
//  kba
//
//  Created by Fiach Reid on 12/04/2018.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class ResultsTableViewController: UITableViewController {

    var SelectedCountry : Countries? = nil
    var Code : String = ""
    
    var Properties = [CarProperty]()
    
    @IBOutlet weak var imageOfCar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        CallWebservice(){
            SVProgressHUD.dismiss()
        }
        
     
    }
    
    func CallWebservice(callback: @escaping () -> Void)
    {
        let url = "https://www.regcheck.org.uk/api/json.aspx/CheckGermany/0005/ALQ"
        Alamofire.request(url, method: .get)
        .authenticate(user: "xxxx", password: "xxxx").responseJSON {
            response in
            print("got Data back")
            let codeJson : JSON = JSON (response.result.value!)
            print(codeJson)
            
            /*
             {
                  "Description": "bmw 318 D TOURING",
                  "CarMake": {
                    "CurrentTextValue": "bmw"
                  },
                  "CarModel": {
                    "CurrentTextValue": "318 D TOURING"
                  },
                  "MakeDescription": {
                    "CurrentTextValue": "bmw"
                  },
                  "ModelDescription": {
                    "CurrentTextValue": "318 D TOURING"
                  },
                  "PowerKW": 105,
                  "PowerHP": 143,
                  "EngineSize": 1995,
                  "Fuel": "Diesel",
                  "ImageUrl": "http://www.kbaapi.de/image.aspx/@Ym13IDMxOCBEIFRPVVJJTkc="
                }
            */
            
            let description = CarProperty(with: "Description")
            description.Value = codeJson["Description"].string!
            self.Properties.append(description)
            
            let PowerKW = CarProperty(with: "Power KW")
            PowerKW.Value = String(codeJson["PowerKW"].int!)
            self.Properties.append(PowerKW)
            
            let PowerHP = CarProperty(with: "Power HP")
            PowerHP.Value = String(codeJson["PowerHP"].int!)
            self.Properties.append(PowerHP)
            
            let EngineSize = CarProperty(with: "Engine Size")
            EngineSize.Value = String(codeJson["EngineSize"].int!)
            self.Properties.append(EngineSize)
            
            let Fuel = CarProperty(with: "Fuel")
            Fuel.Value = codeJson["Fuel"].string!
            self.Properties.append(Fuel)
            
            let image = codeJson["ImageUrl"].string!
            self.imageOfCar.downloadedFrom(link: image)
            
            self.tableView.reloadData()
            
            callback()
        }
    }

  

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Properties.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCell", for: indexPath)

        cell.textLabel?.text = Properties[indexPath.row].Property
        cell.detailTextLabel?.text = Properties[indexPath.row].Value

        return cell
    }
    

}
