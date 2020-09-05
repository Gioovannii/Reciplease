//
//  DescriptionController.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/9/3.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

final class DescriptionController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var ingredients = ["Tomatoes"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DescriptionController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.instructions, for: indexPath)
        
        cell.textLabel?.text = ingredients[indexPath.row]
        cell.textLabel?.font = UIFont(name: K.papyrusFont, size: 20)
        cell.textLabel?.textColor = .white
        return cell
    }
}

