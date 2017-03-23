//
//  Register.swift
//  SkipQueue
//
//  Created by VISHESH MISTRY on 22/03/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class register: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var scrl: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate=self
        mobile.delegate=self
        name.delegate=self
    }
    override func viewDidAppear(_ animated: Bool) {
        scrl.isScrollEnabled=false
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrl.isScrollEnabled = false
        email.resignFirstResponder()
        mobile.resignFirstResponder()
        scrl.setContentOffset(CGPoint(x:0,y:0), animated: true)
        scrl.isScrollEnabled = true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        scrl.setContentOffset(CGPoint(x:0,y:0), animated: true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        scrl.isScrollEnabled=false
        scrl.setContentOffset(CGPoint(x:0,y:170), animated: true)
        // scrl.isScrollEnabled=false
        return true
    }
    
    @IBAction func submit(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
        vc.mob=mobile.text!
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
