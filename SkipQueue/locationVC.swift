//
//  locationVC.swift
//  SkipQueue
//
//  Created by VISHESH MISTRY on 23/03/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class locationVC : UIViewController, UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    @IBOutlet weak var tbl: UITableView!
    var cities=[String]()
    @IBOutlet weak var scrl: UIScrollView!
    var is_searching:Bool=false
     var searchingDataArray:NSMutableArray!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var search: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.parent?.dismiss(animated: false, completion: nil)
       
    cities=["Surat","Mumbai","Delhi","Bangalore","Hyderabad","Ahmedabad"]
        tbl.delegate=self
        tbl.dataSource=self
        search.delegate=self
        tbl.rowHeight=50.0
        is_searching=false
        scrl.isScrollEnabled = false
        searchingDataArray = []
        self.tbl.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.search.endEditing(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        
    
      
      
        
        
        self.tbl.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func viewWillAppear(_ animated: Bool) {
        tbl.tableFooterView = UIView.init(frame: CGRect.zero)
        //tbl.separatorStyle = .none
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //check for search bar text
        if is_searching == true{
            return searchingDataArray.count
        }else{
            return cities.count  //Currently Giving default Value
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //open that location's malls VC
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        if is_searching == true{
            cell.textLabel?.text = (searchingDataArray[indexPath.row] as! NSString) as String
        }else{
            cell.textLabel?.text = (cities[indexPath.row] as NSString) as String
        }
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text?.isEmpty)!{
            is_searching = false
            self.tbl.reloadData()
        } else {
            //print(" search text %@ ",search.text! as String)
            is_searching = true
            //scrl.setContentOffset(CGPoint(x:0,y:120), animated: true)
            searchingDataArray.removeAllObjects()
            for index in 0 ..< cities.count
            {
                var currentString = cities[index] as String
                if currentString.lowercased().range(of: searchText.lowercased())  != nil {
                    searchingDataArray.add(currentString)
                }
            }
            self.tbl.reloadData()
        }
    }
     @IBAction func btn_cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
     }
    
    
}
