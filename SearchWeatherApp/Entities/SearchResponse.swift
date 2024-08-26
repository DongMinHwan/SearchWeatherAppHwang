//
//  Model.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import Foundation


struct SearchResponse: Codable {
    
    let id : Int
    let name : String
    let country : String
    let coord : Coordinates
    
    func getCityName() -> String {
        return name
    }
}

struct Coordinates : Codable {
    let lon : Double
    let lat : Double
}
