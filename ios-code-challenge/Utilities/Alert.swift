//
//  Alert.swift
//  ios-code-challenge
//
//  Created by George Correa on 9/28/19.
//  Copyright © 2019 Dustin Lange. All rights reserved.
//

import Foundation

final class Alert {
    class func showSimpleAlert(with title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }
}
