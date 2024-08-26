//
//  WeatherSearvice.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import Foundation
import Alamofire
import RxSwift

class WeatherService {
    
    func getWeather(lat: Double, lon: Double, units : String = "metric") -> Observable<WeatherResponse> {
        
        let url = Constant.API.url

        let parameters: [String: Any] = [
            "lat": lat,
            "lon": lon,
            "appid": OpenWeatherAPIkey.openWeatherKey,
            "units" : units,
            "cnt" : 35
        ]
        print("parameter : \(parameters)")
        
        return Observable<WeatherResponse>.create { observer -> Disposable in
            
            let request = AF
                .request(url, method: .get, parameters: parameters)
                .validate()
                .responseDecodable(of: WeatherResponse.self) { response in
                    switch response.result {
                    case .success(let weatherResponse):
                        observer.onNext(weatherResponse)
                        observer.onCompleted()
                    case .failure(let error):
                        if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                            print("Response data: \(responseString)")
                        }
                        observer.onError(error)
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}



