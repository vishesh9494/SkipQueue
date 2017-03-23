//
//  OTPVC.swift
//  SkipQueue
//
//  Created by VISHESH MISTRY on 22/03/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class OTPVC: UIViewController,UITextFieldDelegate{
    
    var mob:String=""
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var txt_OTP: UITextField!
    @IBOutlet weak var scrl: UIScrollView!
    @IBOutlet weak var otp_msg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otp_msg.text="Enter the OTP received on \(mob)"
        txt_OTP.delegate=self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        scrl.setContentOffset(CGPoint(x:0,y:0), animated: true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        scrl.setContentOffset(CGPoint(x:0,y:0), animated: true)
        // scrl.isScrollEnabled=false
        return true
    }

    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrl.isScrollEnabled = false
        txt_OTP.resignFirstResponder()
        scrl.setContentOffset(CGPoint(x:0,y:0), animated: true)
        scrl.isScrollEnabled = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrl.isScrollEnabled=false
    }
    
    @IBAction func btn_submit(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "locationVC")
        self.parent?.dismiss(animated: false, completion: nil)
        self.present(vc!, animated: true, completion:nil)
    }

    @IBAction func btn_resend(_ sender: Any) {
        
    }
    
    @IBAction func btn_cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
