//
//  Item.swift
//  Todoey
//
//  Created by Ananth S on 25/03/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

//class Item: Encodable, Decodable {
class Item: Codable {
    var title: String = ""
    var done: Bool = false
}
