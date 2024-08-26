//
//  Color.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import UIKit

class Color {
    extension UIColor {
        
        convenience init(rgb: UInt, alpha:CGFloat = 1.0) {
                self.init(
                    red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                    green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                    blue: CGFloat(rgb & 0x0000FF) / 255.0,
                    alpha: alpha
                
                )
            }
        
 
        //MARK: - 컬러
        static let _white = UIColor(named: "#FFFFFF") ?? UIColor()
    }
}
