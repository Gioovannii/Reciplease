//
//  UIViewController+Alert.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2021/1/6.
//  Copyright © 2021 Jonathan Gaffé. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Alert for handle errors
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}
