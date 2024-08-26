//
//  Extension+UIColor.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import UIKit

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
    static let LightSlateBlue = UIColor(named: "#4A8AB9") ?? UIColor()
    static let DeepSkyBlue = UIColor(named: "#2075b0") ?? UIColor()
    static let LightBlue = UIColor(named: "#7facce") ?? UIColor()
    static let primaryColor = UIColor(named: "#6933FF") ?? UIColor()
    //#7facce
    
}
