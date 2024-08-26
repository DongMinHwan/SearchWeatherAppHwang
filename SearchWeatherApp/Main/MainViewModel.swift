//
//  MainViewModel.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import Foundation
import RxSwift
import RxCocoa


class MainViewModel : BaseViewModel, ViewModelType {
    struct Input{
        var didRefresh = PublishRelay<Void>()
    }
    
    struct Output {
        var currentWeather = PublishRelay<CurrentWeather>()
        var todayWeather = PublishRelay<TodayWeather>()
        var hourWeather = PublishRelay<[HourWeatherResponse]>()
        var weeklyWeather = PublishRelay<[DayWeather]>()
        var coordinate = PublishRelay<Coordinates>()
        var detailWeather = PublishRelay<DetailWeather>()
    }
    
    var input: Input
    var output : Output
    let lat : Double
    let lon : Double
    var service : WeatherService
    
    init(input : Input = Input(),
         output : Output = Output(),
         lat : Double = 0.0,
         lon : Double = 0.0,
         service : WeatherService = WeatherService()) {
        
        self.input = input
        self.output = output
        self.lat = lat
        self.lon = lon
        self.service = service
        
        super.init()
        
        input.didRefresh
            .bind { [weak self] _ in
                guard let self = self else {return}
                self.getWeater(lat: self.lat, lon: self.lon)
            }.disposed(by: self.disposeBag)
        
     
    }
    
    func getWeater(lat: Double, lon : Double) {
        //날씨 호출
        var service = service
            .getWeather(lat: lat, lon: lon)
        
        //현재 날씨

        
        service
            .map{$0.getCurrentWeather()}
            .subscribe{[weak self] data in
                guard let self = self else {return}
                self.output.currentWeather.accept(data)
            }.disposed(by: self.disposeBag)
        
        //오늘 날씨
//        service
//            .map{$0.getTodayWeather()}
//            .bind(to: output.todayWeather)
//            .disposed(by: self.disposeBag)
        service
            .map{$0.getTodayWeather()}
            .subscribe { [weak self] data in
                guard let self = self else {return}
                self.output.todayWeather.accept(data)
            }.disposed(by: self.disposeBag)
        
        //실시간 날씨
        service.subscribe(onNext: { [weak self] (weatherResponse: WeatherResponse) in
            guard let self = self else { return }
            //실시간 날씨
            self.hourWeather(weatherResponse: weatherResponse)
            // 5일간 날씨 추출
            self.updateWeeklyWeather(weatherResponse: weatherResponse)
//            output.hourWeather.accept(hourlyWeatherArray)
        }).disposed(by: self.disposeBag)
        
        //지도
        service
            .map {$0.getCoordinate()}
            .subscribe {[weak self] data in
                guard let self = self else {return}
                self.output.coordinate.accept(data)
            }.disposed(by: self.disposeBag)
      
        //상세날씨
        service
            .map{$0.getDetailWeather()}
            .subscribe{ [weak self] data in
                guard let self = self else {return}
                self.output.detailWeather.accept(data)
            }.disposed(by: self.disposeBag)
   
    }
    
    //실시간
    func hourWeather(weatherResponse: WeatherResponse) {
        
        let list = weatherResponse.list
        var hourlyWeatherArray: [HourWeatherResponse] = []
        
        if !list.isEmpty {
            for i in 0..<list.count {
                
                if hourlyWeatherArray.count == 16 {
                    break
                }
                let weather = list[i]
                let now = Date()
                let currentDay = now.currentDayByInt
                let weatherDay = Int(weather.dtTxt?.split(separator: " ")[0].split(separator: "-").reduce("") { $0 + $1 } ?? "")!
                
                if currentDay <= weatherDay {
                    if currentDay < weatherDay {
                        hourlyWeatherArray.append(weather.getHourlyWeather())
                        
                        continue
                    }
                    
                    let weatherHour = Int(weather.dtTxt?.split(separator: " ")[1].split(separator: ":")[0] ?? "")!
                    let currentHour = now.currentTimeByString
                    
                    if (weatherHour / 3) >= (currentHour / 3) {
                        hourlyWeatherArray.append(weather.getHourlyWeather())
                    }
                }
            }
        }
        
        output.hourWeather.accept(hourlyWeatherArray)
        
    }
    func updateWeeklyWeather(weatherResponse: WeatherResponse) {
        var dailyWeatherDict = [Date: [WeatherItem]]()
        let now = Date()
        let currentDate = now.toLocalTime()
        let calendar = Calendar.current
        // 날씨 데이터를 날짜별로 그룹화하면서 오늘 날짜 이후의 데이터만 포함
        for item in weatherResponse.list {
            if let date = DateFormatter.toDate.date(from: item.dtTxt ?? ""),
               calendar.isDate(date, inSameDayAs: now) || date > now {
                let startOfDay = calendar.startOfDay(for: date)
                dailyWeatherDict[startOfDay, default: []].append(item)
            }
        }
        
        var dayWeathers: [DayWeather] = []
        let sortedDates = Array(dailyWeatherDict.keys.sorted()).prefix(5)  // 첫 5일 선택
         
        for date in sortedDates {
            
            if let weatherItems = dailyWeatherDict[date] {
                let minTemp = weatherItems.map {$0.main.getTempMin()}.min() ?? 0
                let maxTemp = weatherItems.map {$0.main.getTempMax()}.max() ?? 0
                let icon = weatherItems.first?.weather.first?.icon ?? "01d"  // 기본 아이콘
                
                let dayLabel = DateFormatter.toDate.string(from: date).toWeekdayOrToday()  // 확장된 메서드 사용하여 '오늘' 또는 요일을 가져옴
                
                let dayWeather = DayWeather(
                    day: dayLabel,
                    skyIcon: icon,
                    minTemp: Int(minTemp),
                    maxTemp: Int(maxTemp)
                )
                dayWeathers.append(dayWeather)
            }
        }

        // 정렬된 날짜가 오늘부터 시작하는지 확인하고 조정
        if let firstDay = dayWeathers.first, !Calendar.current.isDateInToday(DateFormatter.toDate.date(from: firstDay.day) ?? now) {
            dayWeathers = dayWeathers.filter { Calendar.current.isDateInToday(DateFormatter.toDate.date(from: $0.day) ?? now) }
        }
        output.weeklyWeather.accept(dayWeathers)
    }




    
}
