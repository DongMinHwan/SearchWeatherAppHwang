//
//  Extension+String.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/28/24.
//

import Foundation

extension String {
    func toWeekdayOrToday()  -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")

        guard let date = dateFormatter.date(from: self) else { return self }
        
        if Calendar.current.isDateInToday(date) {
            return "오늘"
        } else {
            dateFormatter.dateFormat = "EEE" // "EEEE"에서 "EEE"로 변경하여 축약형 요일 이름을 얻음
            let fullWeekday = dateFormatter.string(from: date)
            // 축약형 요일 매핑
            switch fullWeekday {
                case "일요일": return "일"
                case "월요일": return "월"
                case "화요일": return "화"
                case "수요일": return "수"
                case "목요일": return "목"
                case "금요일": return "금"
                case "토요일": return "토"
                default: return fullWeekday
            }
        }
    }

    func toFormattedTime() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            // 문자열을 Date 객체로 변환
            guard let date = dateFormatter.date(from: self) else { return self }
            
            // 원하는 출력 형식 설정
            dateFormatter.dateFormat = "a h시" // "a"는 AM/PM을 나타냄, "h"는 시간(1~12)
            dateFormatter.amSymbol = "오전"
            dateFormatter.pmSymbol = "오후"
            dateFormatter.locale = Locale(identifier: "ko_KR") // 로케일을 한국어로 설정
            
            return dateFormatter.string(from: date)
        }

}
