//
//  WeatherResponse.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import Foundation

struct WeatherResponse: Codable {

    var list: [WeatherItem]
    private var city: CityInfo
    
    func getCurrentWeather() -> CurrentWeather {
        let cityName = city.getName()
        
        let weatherInfo = list.first?.getMainInfo()
        let currentTemp = weatherInfo?.getTemp() ?? 0
        let currentMax = weatherInfo?.getTempMax() ?? 0
        let currentMin = weatherInfo?.getTempMin() ?? 0
        
        let currentCondion = list.first?.getWeatherConditon() ?? ""
        print("cityName : \(cityName)")
        return CurrentWeather(
            cityName: cityName,
            currentTemp: currentTemp,
            currentConditon: currentCondion,
            currentTempMax: currentMax,
            currentTempMin: currentMin)
    }
    
    func getTodayWeather() -> TodayWeather {
        let maxGust = list.map { $0.getWindMax() }.max() ?? 0
        list.forEach { data in
            data.getWeatherConditon()
        }
        return TodayWeather(gust: maxGust)
    }
    
    func getCoordinate() -> Coordinates {
        let coord = city.getCoord()
        
        return coord
    }
    //MARK: - 날씨 상세
    func getDetailWeather() -> DetailWeather {
        
        //평균 기압
        let averagePressure = list.map { Double($0.main.getPressure()) }
                                   .reduce(0.0, +) / Double(list.count)
        
        let roundedPressure = Int(averagePressure.rounded())
        
        //평균 바람속도
        let averageWindSpped = list.map {$0.getWindSpped()}
                                   .reduce(0.0, +) / Double(list.count)
        //평균 강풍
        let averageGust = list.map {$0.getWindGust()}
            .reduce(0.0, +) / Double(list.count)
        
        //평균 구름
        let averageClouds = list.map {Double($0.cloud?.getCloud() ?? 0) }
                            .reduce(0.0, +) / Double(list.count)
        
        //평균 습도
        let averagetHumidity = list.map {Double($0.main.gethumidity())}
                                  .reduce(0.0, +) / Double(list.count)
        
        return DetailWeather(pressure: roundedPressure,
                             windSpeed: averageWindSpped,
                             gust: averageGust,
                             clouds: Int(averageClouds), 
                             humidity: Int(averagetHumidity))
    }
    
    
}

struct CityInfo: Codable {
    private var id: Int
    private var name: String
    private var coord: Coordinates
    private var country: String
    private var population: Int
    private var timezone: Int
    private var sunrise: Int
    private var sunset: Int
    
    func getName() -> String {
        return name
    }
    
    func getCoord() -> Coordinates {
        return coord
    }
}

struct WeatherItem : Codable {
    
    var main : MainItem
    var weather : [WeatherInfo]
    var wind : WindInfoItem
    var cloud : Clouuds?
    var dtTxt : String?
    
    func getMainInfo() -> MainItem {
        return main
    }
    
    func getWeatherConditon() -> String {
        return weather.first?.getWeatherCondition() ?? ""
    }
    
    func getWeatherIcon() -> String {
        var icon = weather.first?.getWeatherIcon()
        _ = icon?.removeLast()
        let iconID = (icon ?? "01") + "d"
        
        return iconID
    }
    
    func getWindSpped() -> Double {
        return wind.speed
    }
    
    func getWindGust() -> Double {
        return wind.gust
    }
    
    func getHourlyWeather() -> HourWeatherResponse {
        let hour = dtTxt ?? ""
        let temp = main.getTemp()
        let weatherIcon = getWeatherIcon()
        
        return HourWeatherResponse(
            dateTime: hour,
            temperature: Int(temp),
            icon: weatherIcon
        )
    }
    
    func getWindMax() -> Double {
        return wind.getwindgust()
    }
    
    enum CodingKeys : String, CodingKey {
        case main
        case weather
        case wind
        case dtTxt = "dt_txt"
    }
}
struct MainItem : Codable {
    var temp : Double
    var feelsLike : Double
    var tempMin : Double
    var tempMax : Double
    var pressure : Int
    var seaLevel : Int
    var grndLevel : Int
    var humidity : Int
    var tempKf : Double
    
    func getTemp() -> Double {
//        return temp.toCelsius
        return temp
    }
    
    func getTempMax() -> Double {
//        return tempMax.toCelsius
        return tempMax
    }
    
    func getTempMin() -> Double {
//        return tempMin.toCelsius
        return tempMin
    }
    
    func getPressure() -> Int {
        return pressure
    }
    
    func gethumidity() -> Int {
        return humidity
    }
  
    
    enum CodingKeys : String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}
struct WeatherInfo : Codable {
    var id : Int
    var main : String
    var description : String
    var icon : String
    
    func getWeatherCondition() -> String? {
        return main
    }
    
    func getWeatherIcon() -> String {
        return icon
    }
}

struct WindInfoItem : Codable {
    var speed : Double
    var deg : Int
    var gust : Double // 돌풍
    
    func getwindgust() -> Double {
        return gust
    }
}

struct Clouuds : Codable {
    var all : Int
    
    func getCloud() -> Int {
        return all
    }
}


