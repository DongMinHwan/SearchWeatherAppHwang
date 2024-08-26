//
//  MainView.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import UIKit
import SnapKit
import Then


class MainView : DefaultView {
    
    let scrollView = UIScrollView()
        
    let contentView = UIView().then {
        $0.backgroundColor = .LightSlateBlue
    }
    
    let stackView = VerticalStackView().then {
        $0.spacing = 20
    }
    
    //MARK: - 현재날씨
    let currentWeatherView = CurrentWeatherView()
    //MARK: - 시간별날씨
    let todayWeatherInfoView = TodayWeatherInfoView()
    //MARK: - 5일간 일기예보
    let weeklyWeatherInfoView = WeeklyWeatherInfoView()
    //MARK: - 맵뷰
    let mapView = MapView()
    //MARK: - 기상조건
    let weatherConditionsView = WeatherConditionsView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUI() {
        addSubviews([
                    scrollView])
        
        scrollView.addSubview(contentView)
        
        contentView.addSubviews([currentWeatherView,
                                 todayWeatherInfoView,
                                 weeklyWeatherInfoView,
                                mapView,
                                weatherConditionsView])
    }
    
    func setLayout() {
 
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.searchView.snp.bottom)
           make.left.right.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        currentWeatherView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.right.equalToSuperview()
            
        }
        
        todayWeatherInfoView.snp.makeConstraints { make in
            make.top.equalTo(currentWeatherView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(150)
            
        }
        
        weeklyWeatherInfoView.snp.makeConstraints { make in
            make.top.equalTo(todayWeatherInfoView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
//            make.height.equalTo(400)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(weeklyWeatherInfoView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(mapView.mapView.snp.width)
            

        }
        
        weatherConditionsView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
//            make.height.equalTo(400)
            make.bottom.equalToSuperview().offset(-20)
        }
        
    }
}
