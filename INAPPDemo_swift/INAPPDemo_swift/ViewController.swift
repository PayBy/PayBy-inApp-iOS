//
//  ViewController.swift
//  INAPPDemo_swift
//
//  Created by ice on 2020/6/25.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let onBtn = UIButton(type : .custom)
        onBtn.setTitle("payOrder", for: .normal)
        onBtn.setTitleColor(.black, for: .normal)
        onBtn.backgroundColor = .red
        onBtn.frame = CGRect(x: 100, y: 200, width: 90, height: 30)
        self.view.addSubview(onBtn)
        onBtn.addTarget(self, action:#selector(onClickOfButton), for: .touchUpInside)
        
        
        // Do any additional setup after loading the view.
    }

    
    @objc func onClickOfButton(){
        
          let signStr : NSString = NSString.init(format: "iapAppId=%@&iapDeviceId=%@&iapPartnerId=%@&token=%@", "20200510000000121","deviceId123","200000046800","f6e996e5-4530-4820-b99a-0b537fbf7589")
              SLDPayByPayment.SDLPayByPaymentInterface.request(inApp: "20200510000000121", deviceId: "deviceId123", sign: signStr as String, pageOnViewContorller: self, success: { (result) in
                  print("result\(result)")
              }) { (error) in
                  print(("error\(error)"))
              }
    }

}

