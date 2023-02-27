//
//  ViewController.swift
//  InAppDemo-Swift
//
//  Created by lengchuanxin on 2022/8/24.
//

import UIKit
import SLDPayByPayment
import MBProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var tokenBgView: UIView!
    @IBOutlet weak var tokenTextField: UITextField!
    @IBOutlet weak var appIdBgView: UIView!
    @IBOutlet weak var appIdTextField: UITextField!
    @IBOutlet weak var partnerIdBgView: UIView!
    @IBOutlet weak var partnerIdTextField: UITextField!
    @IBOutlet weak var deviceIdBgView: UIView!
    @IBOutlet weak var deviceIdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Setting", style: .plain, target: self, action: #selector(settingButtonAction))
        
        tokenBgView.layer.cornerRadius = 4
        tokenBgView.layer.borderColor = UIColor.lightGray.cgColor
        tokenBgView.layer.borderWidth = 1
        appIdBgView.layer.cornerRadius = 4
        appIdBgView.layer.borderColor = UIColor.lightGray.cgColor
        appIdBgView.layer.borderWidth = 1
        partnerIdBgView.layer.cornerRadius = 4
        partnerIdBgView.layer.borderColor = UIColor.lightGray.cgColor
        partnerIdBgView.layer.borderWidth = 1
        deviceIdBgView.layer.cornerRadius = 4
        deviceIdBgView.layer.borderColor = UIColor.lightGray.cgColor
        deviceIdBgView.layer.borderWidth = 1
        
        tokenTextField.text = "02c084e52e9740e693e6a9ac9d6801f8"
        appIdTextField.text = GlobalDefines.appId()
        appIdTextField.isEnabled = false
        partnerIdTextField.text = GlobalDefines.partnerId()
        partnerIdTextField.isEnabled = false
        deviceIdTextField.text = "deviceId123"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    @IBAction func paymentButtonAction(_ sender: Any) {
        view.endEditing(true)
        let token = self.tokenTextField.text ?? ""
        let deviceId = self.deviceIdTextField.text ?? ""
        let sign = "iapAppId=\(self.appIdTextField.text ?? "")&iapDeviceId=\(deviceId)&iapPartnerId=\(self.partnerIdTextField.text ?? "")&token=\(token)"
        SLDPayByPaymentInterface.payment(in: self, withToken: token, sign: GPBRSA.encryptString(sign, privateKey: GlobalDefines.privateKey()), deviceId: deviceId) { [weak self] result in
            print("resultCallback: \(result)")
            if SLDPayByPaymentConfig.default().useDefaultResultPage == false {
                self?.showAlert(with: result)
            }
            
            if result == SLDPayByPaymentResultSuccess {
                // Do something
            } else if result == SLDPayByPaymentResultFail {
                // Do something
            } else if result == SLDPayByPaymentResultPaying {
                // Do something
            } else if result == SLDPayByPaymentResultCancel {
                // Do something
            }
        }
    }
    
    @IBAction func placeOrderAction(_ sender: Any) {
        let vc = PlaceOrderViewController()
        vc.confirmHandler = { [weak self] (amount, subject, customerId) in
            guard let `self` = self else { return }
            
            let merchantOrderNo = String(format: "M%.6d%.6d", arc4random_uniform(999999), arc4random_uniform(999999))
            var params: [String: Any] = [:]
            params["requestTime"] = floor(Date().timeIntervalSince1970 * 1000)
            
            var paySceneParams: [String: Any] = [:]
            paySceneParams["appId"] = GlobalDefines.appId()
            paySceneParams["iapDeviceId"] = self.deviceIdTextField.text ?? ""
            if let customerId = customerId, customerId.count > 0 {
                paySceneParams["customerId"] = customerId
            }
            
            params["bizContent"] = [
                "merchantOrderNo": merchantOrderNo,
                "subject": subject,
                "totalAmount": [
                    "currency": "AED",
                    "amount": amount,
                ],
                "paySceneCode": "INAPP",
                "paySceneParams": paySceneParams
            ]
            
            guard let jsonData = try? JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions(rawValue: 0)) else { return }
            guard let sign = String(data: jsonData, encoding: .utf8) else { return }
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
            HttpManager.shared().setValue(GlobalDefines.partnerId(), forHTTPHeaderField: "Partner-Id")
            HttpManager.shared().setValue(GPBRSA.encryptString(sign, privateKey: GlobalDefines.privateKey()), forHTTPHeaderField: "sign")
            HttpManager.shared().post(GlobalDefines.placeOrderUrl(), parameters: params) { responseObject in
                MBProgressHUD.hide(for: self.view, animated: true)
                if let dict = responseObject as? [String: Any],
                   let body = dict["body"] as? [String: Any],
                   let interActionParams = body["interActionParams"] as? [String: Any],
                   let tokenUrl = interActionParams["tokenUrl"] as? String {
                    self.tokenTextField.text = tokenUrl
                    self.paymentButtonAction(self)
                }
            } failure: { error in
                MBProgressHUD.hide(for: self.view, animated: true)
                self.showAlert(with: error.localizedDescription)
            }
        }
        present(vc, animated: false, completion: nil)
    }
    
    @objc func settingButtonAction() {
        let vc = SettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlert(with message: String) {
        let alertController = UIAlertController(title: "Tips", message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default) { action in
            
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
}

