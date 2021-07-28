//
//  UIViewController+Extension.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 27.07.2021.
//

import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String? = nil, with actions: [UIAlertAction]? = nil) {
        let alertMessage = message ?? ""
        let alertActions: [UIAlertAction] = actions ?? [UIAlertAction(title: "OK", style: .default)]

        let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
        alertActions.forEach { (action) in
            alert.addAction(action)
        }

        self.present(alert, animated: true)
    }
}
