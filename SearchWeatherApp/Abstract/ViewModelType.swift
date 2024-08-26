//
//  ViewModelType.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
