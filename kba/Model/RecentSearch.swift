//
//  RecentSearch.swift
//  kba
//
//  Created by user909680 on 4/19/18.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import Foundation
import RealmSwift

class RecentSearch : Object {
    @objc dynamic var Description : String = ""
    @objc dynamic var Image : String = ""
    @objc dynamic var Code : String = ""
    @objc dynamic var Country : Countries = .Germany
}
