//
//  RNManagerVC.swift
//  RNBridgeSwift
//
//  Created by Zero on 2017/3/28.
//  Copyright © 2017年 macbook. All rights reserved.
//

import UIKit

typealias BackBlock = (_ message: Any) -> ()

typealias NextBlock = (_ vc: UIViewController, _ message: Any) -> ()

class RNManagerVC: UIViewController {

    var backBlock: BackBlock?
    var nextBlock: NextBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    convenience init(backBlock: @escaping BackBlock, nextBlock: @escaping NextBlock) {
        
        self.init()
        
        self.backBlock = backBlock;
        self.nextBlock = nextBlock;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(RNManagerVC.backPreviousVC(_:)), name: NSNotification.Name.init(rawValue: "NotificatioinBack"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(RNManagerVC.backPreviousVC(_:)), name: NSNotification.Name.init(rawValue: "NotificatioinNext"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self);
    }
}


extension RNManagerVC {
    func backPreviousVC(_ notification: Notification) {
        
        print("current Thread %@",Thread.current)

        DispatchQueue.main.async { 
            
            if (self.backBlock != nil) {
                self.backBlock!(notification.object ?? "");
            }
            
            if let navigationVC: UINavigationController = self.navigationController, navigationVC.viewControllers.count > 1 {
                
                navigationVC.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
    func nextHandle(_ notification: Notification) {
        print("current Thread %@",Thread.current)
 
        DispatchQueue.main.async {
            if (self.backBlock != nil) {
                self.backBlock!(notification.object ?? "");
            }
        }
    }
}
