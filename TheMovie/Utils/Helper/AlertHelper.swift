//
//  AlertHelper.swift
//  TheMovie
//
//  Created by Adriancys Jesus Villegas Toro on 9/9/23.
//

import Foundation
import UIKit

class AlertHelper {
    
    public static func showAlert(message: String, navigation: UIViewController) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        navigation.present(alert, animated: true)
    }
}
