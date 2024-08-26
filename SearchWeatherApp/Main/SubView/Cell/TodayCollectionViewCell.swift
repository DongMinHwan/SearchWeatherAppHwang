//
//  TodayCollectionViewCell.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/27/24.
//

import UIKit
import SnapKit
import Then


class TodayCollectionViewCell : UICollectionViewCell {
    
    static let registerId =  "\(TodayCollectionViewCell.self)"

    let timeLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12)
    }
    
    let weatherIcon = UIImageView().then {
        $0.backgroundColor = .clear
    }
    
    let tempLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        
    }
     
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUI() {
        addSubviews([timeLabel,
                    weatherIcon,
                    tempLabel])
    }
    
    func setLayout() {
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(40)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setUpdate(_ data : HourWeatherResponse, _ index : Int) {
        timeLabel.text = (index == 0) ? "지금" : (data.dateTime.toFormattedTime() ?? "")
        let skyIcon = "\(data.icon.prefix(2))d"
        let image = UIImage(named: skyIcon)
        weatherIcon.image = image
        tempLabel.text = "\(data.temperature)°"
    }
}
