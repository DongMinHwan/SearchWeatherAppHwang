//
//  Model.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/27/24.
//

import Foundation

//현재날씨
struct CurrentWeather {
    var cityName: String
    var currentTemp : Double
    var currentConditon : String
    var currentTempMax : Double
    var currentTempMin : Double
}

//오늘 실시간 날씨
struct TodayWeather {
    var gust : Double
}

//상세 날씨
struct DetailWeather {
    var pressure : Int
    var windSpeed : Double
    var gust : Double
    var clouds : Int
    var humidity : Int
}

//주간날씨
struct WeeklyWeather {
    var dayWeather: [DayWeather]
}

struct DayWeather {
    var day: String
    var skyIcon: String
    var minTemp: Int
    var maxTemp: Int
}








