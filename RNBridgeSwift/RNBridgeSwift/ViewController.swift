//
//  ViewController.swift
//  RNBridgeSwift
//
//  Created by Zero on 2017/3/27.
//  Copyright © 2017年 macbook. All rights reserved.
//

import UIKit
import React

class ViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var thankLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Handle
    @IBAction func jumpReactNative(_ sender: UIButton) {
        
        let localJSPath = URL.init(string: "http://localhost:8081/index.ios.bundle?platform=ios")

        
        let params:[String:Array<Dictionary<String, String>>] = [
            "scores" : [
                ["name":"Alex","value":"42"],
                ["name":"Joel","value":"10"],
            ]
        ]
        
        let rootView: RCTRootView = RCTRootView(bundleURL: localJSPath, moduleName: "RNTestViewModule", initialProperties: params, launchOptions: nil)
        
        let rnViewController = RNManagerVC.init(backBlock: { (backParams) in
            print(backParams)
            
            if backParams is Dictionary<String, String>  {
                
                let dict = backParams as! Dictionary<String, String>
                
                self.welcomeLabel.text = dict["name"]
                self.thankLabel.text = dict["url"]
            }
            
        }) { (vc, nextParams) in
            print("vc=%@ \n  params=%@",vc,params)
        }
        rnViewController.view = rootView;
        rnViewController.title = "承载RN视图的VC"
        self.navigationController?.pushViewController(rnViewController, animated: true)
        
    }
}

