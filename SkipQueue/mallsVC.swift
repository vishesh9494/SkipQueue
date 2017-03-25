//
//  mallsVC.swift
//  SkipQueue
//
//  Created by VISHESH MISTRY on 23/03/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class mallsVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate{
    
    @IBOutlet weak var scrl: UIScrollView!
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var search: UISearchBar!
    //var dict:NSDictionary!
    var is_searching:Bool!
    var city:String=""
    var mall = [String]()
    var all_malls = [[String]]()
    var searchingDataArray = [[String]]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if is_searching == true{
            return searchingDataArray.count
        }else{
            return all_malls.count  //Currently Giving default Value
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //open cart VC
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCell(withIdentifier: "customCellMalls", for: indexPath) as! customCellMalls
        var mall_cell = [String]()
        if (is_searching==true){
            mall_cell = searchingDataArray[indexPath.row]
            cell.mall_name.text = (mall_cell[0] as! String)
            cell.mall_add.text = (mall_cell[1] as! String)
            cell.mall_contact.text = (mall_cell[2] as! String)
            cell.mall_image_url = (mall_cell[3] as! String)
        }
        else{
            mall_cell = all_malls[indexPath.row]
                /*mall_cell[0] = [all_malls[indexPath.row]][0][0]
            mall_cell[1] = [all_malls[indexPath.row]][1]
            mall_cell[2] = [all_malls[indexPath.row]][2]
            mall_cell[3] = [all_malls[indexPath.row]][3]*/
            cell.mall_name.text = mall_cell[0] as? String
            cell.mall_add.text = (mall_cell[1] as! String)
            cell.mall_contact.text = (mall_cell[2] as! String)
            cell.mall_image_url = (mall_cell[3] as! String)
        }
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text?.isEmpty)!{
            is_searching = false
            self.tbl.reloadData()
        }
        else{
            is_searching = true
            searchingDataArray.removeAll()
            for index in 0 ..< all_malls.count
            {
                let currentString = all_malls[index][0] as! String
                if currentString.lowercased().range(of: searchText.lowercased())  != nil {
                    searchingDataArray.append(all_malls[index])
                }
            }
            self.tbl.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        tbl.tableFooterView = UIView.init(frame: CGRect.zero)
        //tbl.separatorStyle = .none
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.search.endEditing(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tbl.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.delegate=self
        tbl.dataSource=self
        search.delegate=self
        is_searching=false
        scrl.isScrollEnabled = false
        self.tbl.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        getMalls()
    }
    func getMalls(){
        var db=DatabaseManager()
        var flag=false
        db.GeneratePostString(dict: ["City":city])
        db.GetRequest(url: "http://onetouch.16mb.com/SkipQ/getmalls.php")
        DispatchQueue.global(qos: .userInteractive).async {
            flag=db.CreateTask(view: self.view)
            
        }
        while(flag != true){
            
        }
        var array=db.getjson()
        if((array[array.count-1] as! [String:String])["flag"] == "0"){
            var alert=UIAlertController.init(title: "OK", message: "OK", preferredStyle: .alert)
            var OK=UIAlertAction.init(title: "OK", style: .default){
                (ACTION)->Void in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(OK);
            present(alert, animated: true, completion: nil)
        }
        else{
            for var i in 0 ... array.count-2{
                var arr=array[i] as! [String:String]
                mall=[arr["MallName"]!,arr["Address"]!,arr["ContactNo"]!,arr["ImageURL"]!]
                all_malls.append(mall)
            }

        }
        
    }
}
