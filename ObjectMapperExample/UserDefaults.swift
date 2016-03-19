//
//  UserDefaults.swift
//  LocalWeBContent2
//
//  Created by Andrew Stec on 2016-03-18.
//  Copyright © 2016 Andrew Stec. All rights reserved.
//

import UIKit

class UserDefaults: NSObject {
    
    var id: AnyObject;
    var name: AnyObject;
    var streetAddress: AnyObject;
    
    init(id: AnyObject, name: AnyObject, streetAddress: AnyObject) {
        self.id = id;
        self.name = name;
        self.streetAddress = streetAddress;
    }
}
