//
//  BaseView.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import UIKit

class BaseView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .DeepSkyBlue
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

