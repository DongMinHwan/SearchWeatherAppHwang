//
//  Extension+DateFormatter.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/27/24.
//

import Foundation

extension DateFormatter {
    static let toDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "ko_KR") // UTC를 기준으로 설정, 필요에 따라 변경
        return formatter
    }()
}

//yyyyMMddHHmmss
