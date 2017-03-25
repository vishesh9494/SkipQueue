//
//  customCellMalls.swift
//  SkipQueue
//
//  Created by VISHESH MISTRY on 23/03/17.
//  Copyright © 2017 VISHESH MISTRY. All rights reserved.
//

import Foundation
import UIKit

class customCellMalls : UITableViewCell{
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var mall_image: UIImageView!
    @IBOutlet weak var mall_name: UILabel!
    @IBOutlet weak var mall_add: UILabel!
    @IBOutlet weak var mall_contact: UILabel!
    var mall_image_url:String = ""
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
