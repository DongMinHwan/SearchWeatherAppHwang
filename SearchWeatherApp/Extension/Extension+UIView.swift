//
//  Extension+UIView.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
      get {
        return layer.borderWidth
      }
      set {
        layer.borderWidth = newValue
      }
    }

    
    @IBInspectable
    var borderColor: UIColor? {
      get {
        if let color = layer.borderColor {
          return UIColor(cgColor: color)
        }
        return nil
      }
      set {
        if let color = newValue {
          layer.borderColor = color.cgColor
        } else {
          layer.borderColor = nil
        }
      }
    }
}
