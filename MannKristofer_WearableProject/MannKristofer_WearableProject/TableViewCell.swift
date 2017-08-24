//
//  TableViewCell.swift
//  MannKristofer_WearableProject
//
//  Created by Kristofer Klae Mann on 8/24/17.
//  Copyright © 2017 Kristofer Klae Mann. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    // Label for each of the passwords
    @IBOutlet weak var passwordLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
