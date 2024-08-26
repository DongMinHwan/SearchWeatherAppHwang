//
//  CommonTextField.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import UIKit
import SnapKit
import Then

class CommonTextField : UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
       
    }
    
    private func setup() {
        textColor = .white
        font = .systemFont(ofSize: 14)
        layer.masksToBounds = false
        textAlignment = .left
        leftViewMode = .always
        spellCheckingType = .no
        layer.cornerRadius = 4
        layer.masksToBounds = true
        isSecureTextEntry = true
        self.borderColor = .LightBlue
        self.borderWidth = 1
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 1))
               leftView = leftPaddingView
               leftViewMode = .always
    }
}

class SearchTextField : CommonTextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
