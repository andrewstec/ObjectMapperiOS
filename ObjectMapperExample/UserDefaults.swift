//
//  UserDefaults.swift
//  LocalWeBContent2
//
//  Created by Andrew Stec on 2016-03-18.
//  Copyright © 2016 Andrew Stec. All rights reserved.
//

import ObjectMapper
import UIKit

class UserDefaults: Mappable {
    
    var id: AnyObject?;
    var name: AnyObject?;
    var streetAddress: AnyObject?;
    
    required init?(_ map: Map) {
        
    }
    
    init(id: AnyObject, name: AnyObject, streetAddress: AnyObject) {
        self.id = id;
        self.name = name;
        self.streetAddress = streetAddress;
    }
    
    // Mappable
    func mapping(map: Map) {
        id    <- map["id"]
        name         <- map["name"]
        streetAddress      <- map["streetAddress"]

    }
}
