//
//  Extension+Date.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/27/24.
//

import Foundation


extension Date {
    
    
    func toLocalTimeString(format: String = "yyyy-MM-dd HH:mm:ss", timeZone: TimeZone = TimeZone(identifier: "Asia/Seoul")!) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = timeZone
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
    
    var currentDayByInt: Int {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        
        let nowInt = Int(formatter.string(from: now).split(separator: "-").reduce("") { $0 + $1 })!
        
        return nowInt
    }
    
    func toLocalTime(timeZone: TimeZone = TimeZone(identifier: "Asia/Seoul")!) -> Date {
          let secondsFromGMT = TimeInterval(timeZone.secondsFromGMT(for: self))
          return Date(timeInterval: secondsFromGMT, since: self)
      }
 
    
    var currentTimeByString: Int {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        formatter.locale = Locale(identifier: "ko_KR")
        
        let hour = Int(formatter.string(from: now))!
        
        return hour
    }}
