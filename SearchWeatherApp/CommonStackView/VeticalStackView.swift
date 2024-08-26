//
//  VeticalStackView.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import Foundation
import UIKit

class VerticalStackView : UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class HorizontalStackView : UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fill
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
