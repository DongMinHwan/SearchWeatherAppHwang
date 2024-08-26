//
//  CommonDetailWheaterView.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/27/24.
//

import Foundation
import UIKit
import SnapKit
import Then

class CommonDetailWheaterView : BaseView {
    
    var statusLabel = UILabel().then {
        $0.text = "습도"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12)
    }
    
    var statusValueLabel = UILabel().then {
        $0.text = "습도"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 28)
    }
    
    var statusDetailValueLabel = UILabel().then {
        $0.text = "바람속도"
        $0.backgroundColor = .clear
        $0.isHidden = true
        $0.font = .systemFont(ofSize: 12)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        addSubviews([statusLabel,
                    statusValueLabel,
                    statusDetailValueLabel])
        
    }
    
    func setLayout() {
        statusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
        }
        
        statusValueLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        statusDetailValueLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(8)
        }
        
    }
    
}
