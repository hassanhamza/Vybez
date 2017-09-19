//
//  Controller.swift
//  ContactInvites
//
//  Created by Hassan on 2/20/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit
extension UIViewController {
    
    func showErrorAlert(_ withTitle: String = "Error", message: String, actions: [UIAlertAction]? = nil) {
        let actionSheetController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let actions = actions {
            for action in actions {
                actionSheetController.addAction(action)
            }
        } else {
            let okActionButton: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) { action -> Void in
            }
            actionSheetController.addAction(okActionButton)
        }
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.backgroundColor = UIColor.clear
        alertWindow.rootViewController = UIViewController()
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(actionSheetController, animated: true, completion: nil)
    }
    
}
