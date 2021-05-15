//
//  DescriptionDataSource.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/12/6.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

final class DescriptionDataSource: NSObject {

    // MARK: - Properties
    
    var ingredients = [String]()
    var title: String?
    
    // MARK: - Methods
    
    func update(with ingredients: [String], title: String) {
        self.ingredients = ingredients
        self.title = title
    }
}

// MARK: - UItableView DataSource

extension DescriptionDataSource: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.instructions, for: indexPath)
        
        cell.textLabel?.text = ingredients[(indexPath.row)]
        cell.textLabel?.font = UIFont(name: Constant.papyrusFont, size: 17)
        cell.textLabel?.textColor = .black
        return cell
    }

     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  title
    }
}




