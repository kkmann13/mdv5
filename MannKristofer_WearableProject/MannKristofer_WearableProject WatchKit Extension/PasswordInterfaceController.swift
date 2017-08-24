//
//  PasswordInterfaceController.swift
//  MannKristofer_WearableProject
//
//  Created by Kristofer Klae Mann on 8/13/17.
//  Copyright © 2017 Kristofer Klae Mann. All rights reserved.
//

import WatchKit
import Foundation


class PasswordInterfaceController: WKInterfaceController {
    
    @IBOutlet var passwordsTable: WKInterfaceTable!
    @IBOutlet var passwordLabel: WKInterfaceLabel!
    
    var passwordsArray = [String]()

    // This receives the context of an array of passwords from the InterfaceController and sets it to the passwordsArray
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        passwordsArray = context as! [String]
    
    }

    // This sets the number of rows in the table to the count of the passwordsArray
    // The it loops through the array and sets the label's text to each password
    override func willActivate() {
        super.willActivate()
        passwordsTable.setNumberOfRows(passwordsArray.count, withRowType: "Row")
        for index in 0..<passwordsArray.count {
            let row = passwordsTable.rowController(at: index) as! PasswordRowController
            row.passwordLabel.setText(passwordsArray[index])
        }
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

}
