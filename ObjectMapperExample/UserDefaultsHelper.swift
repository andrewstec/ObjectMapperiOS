//
//  UserDefaultsHelper.swift
//  LocalWeBContent2
//
//  Created by Andrew Stec on 2016-03-16.
//  Copyright © 2016 Andrew Stec. All rights reserved.
//

import ObjectMapper
import UIKit

class UserDefaultsHelper: NSObject {

    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    func setDefaultValues(id: AnyObject, name: AnyObject, streetAddress: AnyObject) {
        userDefaults.setObject(id, forKey: "id");
        userDefaults.setObject(name, forKey: "name");
        userDefaults.setObject(streetAddress, forKey: "streetAddress");
        print (userDefaults.objectForKey("id")!);
        print (userDefaults.objectForKey("name")!);
        print (userDefaults.objectForKey("streetAddress")!);
    }
    
    func getValue() -> AnyObject {
        if userDefaults.objectForKey("id") != nil  {
            let userDefaultsObject = UserDefaults(id: userDefaults.objectForKey("id")!, name: userDefaults.objectForKey("name")!, streetAddress: userDefaults.objectForKey("streetAddress")!)
            let JSONString = Mapper().toJSONString(userDefaultsObject)
            return JSONString!
        }
        else {
            return UserDefaults(id: 0, name: "null", streetAddress: "null")
        }
    }
}
