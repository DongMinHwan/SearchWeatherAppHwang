//
//  ViewModelBindableType.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import Foundation
import UIKit


protocol ViewModelBindableType {
    associatedtype ViewModelType
    var viewModel : ViewModelType! {get set} //
    func bindInput()
    func bindOutput()
}


extension ViewModelBindableType where Self: UIViewController {
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bindInput()
        bindOutput()
    }
}
