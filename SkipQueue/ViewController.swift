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
        let db=DatabaseManager()
        var dict:NSDictionary=["email":email.text,"mobile":mobile.text]
        var flag = false
        db.GeneratePostString(dict:dict)
        db.GetRequest(url: "http://onetouch.16mb.com/SkipQ/login.php")
        DispatchQueue.global(qos: .userInteractive).async {
            flag=db.CreateTask(view: self.view)
            
        }
        while(flag != true){
            
        }
        var array=(db.getjson())[0] as! [String:String]
        if(array["flag"] == "1"){
            // open the next page
            performSegue(withIdentifier: "login_to_otp", sender: self)
        }
        else{
            var alert=UIAlertController.init(title: "Wrong details", message: "Please Check your credentials", preferredStyle: .alert)
            var ok=UIAlertAction.init(title: "OK", style: .default){
                (ACTION)->Void in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier=="login_to_otp"){
            let vc = segue.destination as! OTPVC
            vc.mob = mobile.text!
        }
        if(segue.identifier=="login_to_register"){
            let vc = segue.destination as! register
        }
    }
    
    @IBAction func register(_ sender: Any) {
        email.resignFirstResponder()
        mobile.resignFirstResponder()
        performSegue(withIdentifier: "login_to_register", sender: self)
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
        email.text="risha@gmail.com"
        mobile.text="9327005120"
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

