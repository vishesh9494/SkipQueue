//
//  ViewController.swift
//  SkipQueue
//
//  Created by VISHESH MISTRY on 21/03/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var scrl: UIScrollView!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var logo: UIImageView!
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrl.isScrollEnabled = false
        email.resignFirstResponder()
        mobile.resignFirstResponder()
        scrl.setContentOffset(CGPoint(x:0,y:0), animated: true)
        scrl.isScrollEnabled = true
        
    }

    @IBAction func login(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
        vc.mob=mobile.text!
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func register(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "register")
        email.resignFirstResponder()
        mobile.resignFirstResponder()
        self.present(vc!, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        scrl.setContentOffset(CGPoint(x:0,y:0), animated: true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        scrl.setContentOffset(CGPoint(x:0,y:170), animated: true)
       // scrl.isScrollEnabled=false
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrl.delegate=self
        email.text="shreya@iitj.ac.in"
        mobile.text="9875439875"
        email.delegate=self
        mobile.delegate=self
        self.view.isUserInteractionEnabled=true
        scrl.canCancelContentTouches=false
        scrl.delaysContentTouches=true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

