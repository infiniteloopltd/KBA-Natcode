//
//  VinSearchViewController.swift
//  kba
//
//  Created by user909680 on 4/30/18.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import TransitionButton
import Alamofire
import SwiftyJSON

class VinSearchViewController: UIViewController {

    @IBOutlet weak var tabButton: UITabBarItem!
    
    @IBOutlet weak var VinSearchTextBox: SkyFloatingLabelTextField!
    
    @IBOutlet weak var SearchButton: TransitionButton!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vinPlaceholder = NSLocalizedString("VIN number", comment: "")
        let vinTitle = NSLocalizedString("Enter a VIN number", comment: "")
        let searchText = NSLocalizedString("Search", comment: "")
        VinSearchTextBox.placeholder = vinPlaceholder
        VinSearchTextBox.title = vinTitle
       
        VinSearchTextBox.tintColor = UIColor.flatMint // the color of the blinking cursor
        VinSearchTextBox.textColor = UIColor.gray
        VinSearchTextBox.lineColor = UIColor.gray
        VinSearchTextBox.selectedTitleColor = UIColor.flatMint
        VinSearchTextBox.selectedLineColor = UIColor.flatMint
        VinSearchTextBox.lineHeight = 1.0 // bottom line height in points
        VinSearchTextBox.selectedLineHeight = 2.0
        
        SearchButton.backgroundColor = UIColor.flatMint
        SearchButton.setTitle(searchText, for: .normal)
        SearchButton.cornerRadius = 20
        SearchButton.spinnerColor = .white
    }
    
  
    
    func DoVinSearch(vin:String,completion: @escaping (JSON?) -> Void)
    {
        let strUrl = "https://www.regcheck.org.uk/api/json.aspx/VinCheck/\(vin)"
        Logging.Log(Channel: "kba", Log: strUrl)
        Alamofire.request(strUrl, method: .get)
        .authenticate(user: Secret.username , password: Secret.password).responseJSON {
            response in
            print("got Data back")
            if (response.result.value == nil)
            {
                completion(nil)
                return
            }
            let vinJson : JSON = JSON (response.result.value!)
            print(vinJson)
            completion(vinJson)
        }
    }
    
    
    @IBAction func searchButtonPressed(_ sender: TransitionButton) {
     let vin = VinSearchTextBox.text!
     sender.startAnimation()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            self.DoVinSearch(vin: vin,completion: { (result) in
                DispatchQueue.main.async(execute: { () -> Void in
                    if result != nil {
                     sender.stopAnimation(animationStyle: .expand, completion: {
                       GlobalSettings.SelectedCountry = .International
                       GlobalSettings.Data = result
                       self.performSegue(withIdentifier: "goToResultsFromVinSearch", sender: self)
                     })
                    }
                    else
                    {
                        sender.stopAnimation(animationStyle: .shake, completion: nil)
                    }
                })
            })
        })
    }
    
   



}
