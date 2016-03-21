//
//  ViewController.swift
//  LocalWeBContent2
//
//  Created by Andrew Stec on 2016-03-16.
//  Copyright © 2016 Andrew Stec. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler {
    
    let userDefaultsHelper = UserDefaultsHelper()
    var myWebView: WKWebView!
    
    override func loadView() {
        super.loadView()
        // Do any additional setup after loading the view, typically from a nib.
        
        //first, we'll set up a bridge between the javascript file and this controller
        let contentController = WKUserContentController()
        let userDefaultsHelper = UserDefaultsHelper()
        let userDefaultsJSON = userDefaultsHelper.getValue()

        let userScript = WKUserScript(
            source: "loadUserDefaults('" + String(userDefaultsJSON) + "')",
            injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
            forMainFrameOnly: true
        )


        
        contentController.addUserScript(userScript)
        
        contentController.addScriptMessageHandler(
            self,
            name: "callbackHandler"
        )
        
        contentController.addScriptMessageHandler(
            self, name: "callWebkitInterface"
        )
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        self.myWebView = WKWebView(frame: self.view.frame, configuration: config)
        self.view = self.myWebView!
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaultsObject = userDefaultsHelper.getValue()
        print(userDefaultsObject)
        
        let url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("index", ofType: "html")!)
        let req = NSURLRequest(URL: url)
        self.myWebView!.loadRequest(req)
    }
    
    //setup callback handler below:
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        if(message.name == "callbackHandler") {
            print ("Sending object to UserDefaults")
            print("testy" + String(message.body))
            let jsonUserDefaults = message.body["userDefaults"] as! NSDictionary
            let userDefaultsHelper = UserDefaultsHelper()
            userDefaultsHelper.setDefaultValues(jsonUserDefaults["id"]!, name: jsonUserDefaults["name"]!, streetAddress: jsonUserDefaults["streetAddress"]!)
            
            
            print(jsonUserDefaults)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

