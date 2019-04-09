//
//  ViewController.swift
//  yuzTanima
//
//  Created by SUMBUL on 18.02.2018.
//  Copyright © 2018 SUMBUL. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonClicked(_ sender: Any) {
        let laContext = LAContext()
        var error: NSError?
        let biometricsPolicy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
        
        if (laContext.canEvaluatePolicy(biometricsPolicy, error: &error)) {
            
            if let laError = error {
                print("laError - \(laError)")
                return
            }
            
            var localizedReason = "Unlock device"
            if #available(iOS 11.0, *) {
                if (laContext.biometryType == LABiometryType.faceID) {
                    localizedReason = "Unlock using Face ID"
                    print("FaceId support")
                } else if (laContext.biometryType == LABiometryType.touchID) {
                    localizedReason = "Unlock using Touch ID"
                    print("TouchId support")
                } else {
                    print("No Biometric support")
                }
            } else {
                // Fallback on earlier versions
            }
            
            
            laContext.evaluatePolicy(biometricsPolicy, localizedReason: localizedReason, reply: { (isSuccess, error) in
                
                DispatchQueue.main.async(execute: {
                    
                    if let laError = error {
                        print("laError - \(laError)")
                    } else {
                        if isSuccess {
                            print("sucess")
                            self.performSegue(withIdentifier: "Kontrol", sender:  nil)
                        } else {
                            
                            let Alert =  UIAlertController(title: "alert", message: "üzgünüz hevesinizi kırdık şampiyon yine BEŞİKTAŞ", preferredStyle: UIAlertControllerStyle.alert)
                            
                            let OkButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel , handler: nil)
                            Alert.addAction(OkButton)
                            self.present(Alert , animated: true,  completion: nil)
                        }
                    }
                    
                })
            })
        }
    }
    
}

