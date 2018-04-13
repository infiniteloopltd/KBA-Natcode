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

   
    
    var Properties = [CarProperty]()
    
    @IBOutlet weak var imageOfCar: UIImageView!
    
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
    

    
    func ProcessGermanJson(with codeJson : JSON)
    {
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
    }
    
    func ProcessAustrianJson(with codeJson : JSON)
    {
        /*
            {
              "Description": "Mitsubishi  Colt CZ3 Invite 1,5 DI-D HP Invite , Diesel",
              "CarMake": {
                "CurrentTextValue": "Mitsubishi "
              },
              "CarModel": {
                "CurrentTextValue": "Colt 3-tg. Diesel"
              },
              "MakeDescription": {
                "CurrentTextValue": "Mitsubishi "
              },
              "ModelDescription": {
                "CurrentTextValue": "Colt 3-tg. Diesel"
              },
              "PowerKW": 70,
              "PowerHP": 95,
              "EngineSize": 1493,
              "IndicativeValue": 16490,
              "DateRange": "2005-2007",
              "ImageUrl": "http://www.natcode.at/image.aspx/@TWl0c3ViaXNoaSAgQ29sdCAzLXRnLiBEaWVzZWw="
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
        
            let IndicativeValue = CarProperty(with: "IndicativeValue")
            IndicativeValue.Value = "€" + String(codeJson["IndicativeValue"].int!)
            self.Properties.append(IndicativeValue)
        
            let DateRange = CarProperty(with: "Date Range")
            DateRange.Value = codeJson["DateRange"].string!
            self.Properties.append(DateRange)
        
        
            let image = codeJson["ImageUrl"].string!
            self.imageOfCar.downloadedFrom(link: image)
    }
    
    
    func CallWebservice(callback: @escaping (Bool) -> Void)
    {
        var url = ""
        
        if GlobalSettings.SelectedCountry == .Germany
        {
            // Sample 0005/ALQ
            url = "https://www.regcheck.org.uk/api/json.aspx/CheckGermany/" + GlobalSettings.SelectedCode
        }

        if GlobalSettings.SelectedCountry == .Austria
        {
            // 128740
            url = "https://www.regcheck.org.uk/api/json.aspx/CheckAustria/" + GlobalSettings.SelectedCode;
        }
     
        Alamofire.request(url, method: .get)
        .authenticate(user: Secret.username , password: Secret.password).responseJSON {
            response in
            
            // To-do: Handle failure case with alert!
            
            print("got Data back")
            if (response.result.value == nil)
            {
                callback(false)
                return
            }
            let codeJson : JSON = JSON (response.result.value!)
            print(codeJson)
            
            if GlobalSettings.SelectedCountry == .Germany
            {
                self.ProcessGermanJson(with: codeJson)
            }
            
            if GlobalSettings.SelectedCountry == .Austria
            {
                self.ProcessAustrianJson(with: codeJson)
            }
            
            self.tableView.reloadData()
            
            callback(true)
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
