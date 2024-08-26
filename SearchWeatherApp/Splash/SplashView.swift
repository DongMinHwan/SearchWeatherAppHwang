//
//  SplashView.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import UIKit
import SnapKit
import Then

class SplashView : UIView {
    
    
    private let splashImageView = UIImageView().then {
        $0.image = UIImage(named: "01d")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        self.backgroundColor = .LightSlateBlue
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // addsubView
    func setUI(){
        self.addSubview(splashImageView)
    }
    
    func setLayout() {
        
        splashImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(90)
        }
        
    }
}
