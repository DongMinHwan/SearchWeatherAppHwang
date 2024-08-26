//
//  Extension+Double.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/27/24.
//

import Foundation

extension Double {
    // 화씨를 섭씨로 변환
    var toCelsius: Double {
        return self - 273.15
    }
    
    //소숫점 둘째 짜리
    var formattedAsTwoDecimal: String {
        return String(format: "%.2f", self)
    }
}
