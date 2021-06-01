//
//  AlertController.swift
//  TintThat
//
//  Created by Sebastian Cruz on 01/06/21.
//

import UIKit

class AlertController {
    static func showStateAlert(controller: UIViewController, title: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        controller.present(alert, animated: true, completion: {
            alert.dismiss(animated: true, completion: completion)
        })
    }
    
    static func showImportantAlert(controller: UIViewController, title: String, leftActionTitle: String, rightActionTitle: String, rightAction: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let leftAction = UIAlertAction(title: leftActionTitle, style: .cancel, handler: nil)
        let rightAction = UIAlertAction(title: rightActionTitle, style: .default, handler: rightAction)
        
        alert.addAction(leftAction)
        alert.addAction(rightAction)
        
        controller.present(alert, animated: true, completion: nil)
    }
}
