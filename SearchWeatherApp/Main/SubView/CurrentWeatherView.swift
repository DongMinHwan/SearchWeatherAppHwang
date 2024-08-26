//
//  CityWheterInfoView.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import UIKit
import RxSwift

class CurrentWeatherView : UIView {
    
    let stackView = VerticalStackView().then {
        $0.spacing = 4
    }
    
    let cityNameLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 45)
    }
    
    let temperatureLabel = UILabel().then {
        $0.text  = "-7"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 55)
    }
    
    let wetherStatusLabel = UILabel().then {
        $0.text  = "맑음"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 35)
    }
    
    let temperatureStatusView = UIView()
    
    //Heiterwang
    
    let horizonStackView = HorizontalStackView().then {
        $0.spacing = 4
    }
    let maxTemperatureLabel = UILabel().then {
        $0.textColor = .white
        $0.text = "최고 : -1"
        $0.font = .systemFont(ofSize: 14)
    }
    
    let speratorView = UIView().then {
        $0.layer.borderWidth = 2.0
        $0.layer.borderColor = UIColor.white.cgColor
    }
    
    let minTemperature = UILabel().then {
        $0.textColor = .white
        $0.text = "최고 : -11"
        $0.font = .systemFont(ofSize: 14)
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

        addSubview(stackView)
        addSubviews([stackView,
                     temperatureStatusView])
        stackView.autoArrangedSubView([cityNameLabel,
                                      temperatureLabel,
                                      wetherStatusLabel])
        
        temperatureStatusView.addSubview(horizonStackView)
        
        horizonStackView.autoArrangedSubView([maxTemperatureLabel,
                                             speratorView,
                                              minTemperature])
        
        
    }
    
    func setLayout() {
        
        stackView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
            make.top.left.right.equalToSuperview()
            
        }
        
        temperatureStatusView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        
        horizonStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.center.equalToSuperview()
        }

        speratorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(12)
            make.width.equalTo(2)
        }
        
    }
    
    func weatherUpdate(_ data : CurrentWeather) {
        print("daata : \(data.cityName)")
        cityNameLabel.text = ""
        cityNameLabel.text = data.cityName
        //Option + Shift + 8 = °
        temperatureLabel.text = "\(Int(data.currentTemp))°"/*String(Int(data.currentTemp))*/
        wetherStatusLabel.text = data.currentConditon
        maxTemperatureLabel.text = "최고: \(Int(data.currentTempMax))°"
        minTemperature.text = "최저: \(Int(data.currentTempMin))°"
    }
}


extension Reactive where Base: CurrentWeatherView {
    var text : Binder<CurrentWeather> {
        return Binder(self.base) { view ,currentweather in
            view.weatherUpdate(currentweather)
        }
    }
}
