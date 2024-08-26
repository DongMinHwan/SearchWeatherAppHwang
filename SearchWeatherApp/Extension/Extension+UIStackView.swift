//
//  Extension+UIStackView.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import UIKit


extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
    
    func autoArrangedSubView(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
