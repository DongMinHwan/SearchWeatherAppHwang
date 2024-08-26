//
//  Extension+Int.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/27/24.
//

import Foundation

extension Int {
    
    var formattedWithCommas: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal // 숫자 형식을 소수점 없는, 콤마로 구분하는 형식으로 설정
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
