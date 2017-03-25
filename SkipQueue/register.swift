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
        email.text = "risha@gmail.com"
        mobile.text = "9327005120"
        name.text = "rishabh"
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
        scrl.setContentOffset(CGPoint(x:0,y:0), animated: true)
        return true
    }
    
    @IBAction func submit(_ sender: Any) {
        let db=DatabaseManager()
        var dict:NSDictionary=["Name":name.text,"Email":email.text,"Mobile":mobile.text]
        var flag=false
        db.GeneratePostString(dict:dict)
        db.GetRequest(url: "http://onetouch.16mb.com/SkipQ/register.php")
        DispatchQueue.global(qos: .userInteractive).async {
            flag=db.CreateTask(view: self.view)
            
        }
        while(flag != true){
            
        }
        performSegue(withIdentifier: "register_to_otp", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="register_to_otp"){
            let vc = segue.destination as! OTPVC
            vc.mob = mobile.text!
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
