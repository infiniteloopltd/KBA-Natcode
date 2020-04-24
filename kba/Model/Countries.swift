//
//  Countries.swift
//  kba
//
//  Created by Fiach Reid on 12/04/2018.
//  Copyright © 2018 Fiach Reid. All rights reserved.
//

import Foundation
import RealmSwift

@objc enum Countries : Int, RealmEnum {
    case Germany // 0005/ALQ
    case Austria
    case International // VIN
}
