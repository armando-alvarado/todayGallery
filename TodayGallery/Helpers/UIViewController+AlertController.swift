//
//  UIViewController+AlertController.swift
//  TodayGallery
//
//  Created by Armando Antonio Alvarado Torres on 08/03/21.
//

import Foundation
import UIKit

extension UIViewController {

    func showAlert(with message: String, onAccept: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: "Today Gallery", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: onAccept))
        self.present(alert, animated: true, completion: nil)
    }
}
