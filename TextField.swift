//
//  TextField.swift
//  SugarBash
//
//  Created by Ahmad Ishfaq on 8/3/16.
//  Copyright © 2016 Ahmad Ishfaq. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
   func changePlaceholderColor(_ color: UIColor) {
      if let placeholder = placeholder, let font = font {
         attributedPlaceholder = NSAttributedString(string: placeholder,
            attributes: [NSForegroundColorAttributeName: color, NSFontAttributeName: font])
      }
   }
   
   func leftpadding(_ width: CGFloat) {
      let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: frame.height))
      view.isUserInteractionEnabled = false
      leftView = view
      leftViewMode = .always
   }
}
