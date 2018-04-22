//
//  BingImageSearch.swift
//  kba
//
//  Created by Fiach Reid on 22/04/2018.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BingImageSearch
{
    // To-Do: This is an excellent candidate for unit testing.
    static func Search(keyword : String, completion: @escaping (UIImage, String) -> Void )
    {
        let escapedString = keyword.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let strUrl = "https://api.cognitive.microsoft.com/bing/v7.0/images/search?q=\(escapedString)&count=1&subscription-key=\(Secret.subscriptionKey)"
        Alamofire.request(strUrl).responseJSON { (response) in
             if response.result.isSuccess {
                let searchResult : JSON = JSON (response.result.value!)
                // To-Do: handle image not found
                let imageResult = searchResult["value"][0]["contentUrl"].string!
                print(imageResult)
                Alamofire.request(imageResult).responseData(completionHandler: { (response) in
                    if response.result.isSuccess {
                        let image = UIImage(data: response.result.value!)
                        completion(image!, imageResult)
                    }
                    else
                    {
                        print("Image Load Failed! \(response.result.error ?? "error" as! Error)")
                    }
                })
            }
            else{
                print("Bing Search Failed! \(response.result.error ?? "error" as! Error)")
            }
        }
    }
}
