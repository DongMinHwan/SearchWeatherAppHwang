//
//  DefaultView.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/27/24.
//
import UIKit

class DefaultView : UIView {
    
    let searchView = SearchHeaderView().then {
        $0.backgroundColor = .LightSlateBlue
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .LightSlateBlue
        addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(45)
            make.left.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
