//
//  RecentSearchesTableViewController.swift
//  kba
//
//  Created by user909680 on 4/19/18.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import UIKit
import RealmSwift

class RecentSearchesTableViewController: UITableViewController {

    let realm = try! Realm()
    
    var recentSearches : Results<RecentSearch>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recentSearches = realm.objects(RecentSearch.self)
        
        if (recentSearches?.count == 0)
        {
            let sorry = NSLocalizedString("Sorry", comment: "")
            let fail = NSLocalizedString("Fail", comment: "")
            Utils.ShowMessage(title: sorry, message: fail, controller: self)
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recentSearches?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let search = recentSearches![indexPath.row]
        cell.textLabel?.text = search.Description
        cell.imageView?.downloadedFrom(url: URL(string: search.Image)!){}
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let search = recentSearches![indexPath.row]
        GlobalSettings.SelectedCountry = search.Country
        GlobalSettings.SelectedCode = search.Code
        performSegue(withIdentifier: "goToResultsFromRecents", sender: self)
    }

}
