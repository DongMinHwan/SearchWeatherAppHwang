//
//  WeatherConditionsView.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import UIKit
import RxSwift

class WeatherConditionsView : BaseView {

    let mainStackView = VerticalStackView().then {
        $0.spacing = 20
    }
    let topStackView = HorizontalStackView()
    let bottomStackView = HorizontalStackView()
    
    //습도
    var humindityView = CommonDetailWheaterView().then {
        $0.statusLabel.text = "습도"
        
    }
    // 구름
    var cloudsView = CommonDetailWheaterView().then {
        $0.statusLabel.text = "구름"
        
    }
    // 바람속도
    var windSpeedView = CommonDetailWheaterView().then {
        $0.statusLabel.text = "바람 속도"
        $0.statusDetailValueLabel.isHidden = false
        $0.statusDetailValueLabel.text = "강풍"
    }
    // 기압
    var pressureView = CommonDetailWheaterView().then {
        $0.statusLabel.text = "기압"
        
    }
    
    let spacing: CGFloat = 16.0
    let padding: CGFloat = 16.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {

        addSubview(mainStackView)
        
        mainStackView.autoArrangedSubView([topStackView,
                                          bottomStackView])
        
        topStackView.autoArrangedSubView([humindityView,
                                         cloudsView])
        
        bottomStackView.autoArrangedSubView([windSpeedView,
                                            pressureView])
        
    }
    
    func setLayout() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let viewWidth = (UIScreen.main.bounds.width - spacing - 2 * padding) / 2
        
        topStackView.spacing = spacing
        
        humindityView.snp.makeConstraints { make in
            make.width.equalTo(viewWidth)
            make.height.equalTo(viewWidth)
        }

        bottomStackView.spacing = spacing
        
        windSpeedView.snp.makeConstraints { make in
            make.width.equalTo(viewWidth)
            make.height.equalTo(viewWidth)
        }
    }
    
    func detailWeatherUpdate(_ data : DetailWeather) {
        //습도
        self.humindityView.statusValueLabel.text = "\(data.humidity) %"
        //구름
        self.cloudsView.statusValueLabel.text = "\(data.clouds) %"
        //바람속도
        self.windSpeedView.statusValueLabel.text = "\(data.windSpeed.formattedAsTwoDecimal)m/s"
        //강풍
        self.windSpeedView.statusDetailValueLabel.text = "\(data.gust.formattedAsTwoDecimal)m/s"
        //기압
        self.pressureView.statusValueLabel.text = "\(data.pressure.formattedWithCommas) hpa"
    }
}

extension Reactive where Base: WeatherConditionsView {
    var text : Binder<DetailWeather> {
        return Binder(self.base) { view ,detailWeather in
            view.detailWeatherUpdate(detailWeather)
        }
    }
}
