//
//  Helper.swift
//  Vybez
//
//  Created by Hassan on 7/29/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import Foundation
import UIKit

open class Helper: NSObject {
    
    open static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        if let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx) as NSPredicate? {
            return emailTest.evaluate(with: email)
        }
        return false
    }
    
    open static func isValidPhoneNumber(_ email: String) -> Bool {
        let phoneREGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        
        if let emailTest = NSPredicate(format: "SELF MATCHES %@", phoneREGEX) as NSPredicate? {
            return emailTest.evaluate(with: email)
        }
        return false
    }


}
