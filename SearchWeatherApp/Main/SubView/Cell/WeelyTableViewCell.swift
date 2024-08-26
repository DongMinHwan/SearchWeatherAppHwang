//
//  WeelyTableViewCell.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/28/24.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class WeelyTableViewCell : UITableViewCell {
    
    static let registerId = "\(WeelyTableViewCell.self)"
    
    var dayOfWeekLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = .white
    }
    
    var weatherIconView = UIImageView()
    
    var tempLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = .white
    }
    
    let seperatorView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .DeepSkyBlue
        setUI()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUI() {
        addSubviews([dayOfWeekLabel,
                    weatherIconView,
                    tempLabel,
                    seperatorView])
    }
    
    func setLayout() {
        
        dayOfWeekLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
        }
        
        weatherIconView.snp.makeConstraints { make in
            make.left.equalTo(dayOfWeekLabel.snp.right).offset(65)
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        seperatorView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func dayWeatherUpdate(_ data : DayWeather) {
        dayOfWeekLabel.text = data.day
        let skyIcon = "\(data.skyIcon.prefix(2))d"
        let image = UIImage(named: skyIcon)
        print("data.skyIcon : \(data.skyIcon)")
        weatherIconView.image = image
        tempLabel.text = "최소\(data.minTemp)° 최대\(data.maxTemp)°"
    }
    
}
