//
//  TableViewController.swift
//  MannKristofer_WearableProject
//
//  Created by Kristofer Klae Mann on 8/13/17.
//  Copyright © 2017 Kristofer Klae Mann. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    private let cellIdentifier = "Cell"
    var passwordsArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    // There will only ever be one section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // It only produces 20 rows of passwords
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    // This sets each cell passwordLabel text to the passwords in the passwordsArray based upon indexPath's row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        for _ in 0..<passwordsArray.count {
            cell.passwordLabel.text = passwordsArray[indexPath.row]
        }

        return cell
    }
 

}
