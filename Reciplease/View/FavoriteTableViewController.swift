//
//  FavoriteTableViewCOntrollerTableViewController.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/9/23.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit


class FavoriteTableViewController: UITableViewController {

    
    var coreDataManager: CoreDataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        coreDataManager = CoreDataManager(coreDataStack: appDelegate.coreDataStack)
       // print(coreDataManager?.recipes.first?.title)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}
