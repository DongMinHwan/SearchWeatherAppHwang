//
//  BaseViewModel.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import Foundation
import RxCocoa
import RxSwift
import RxViewController

class BaseViewModel {
    
    deinit {
        print(">>>>>>>>>>>>>\(Self.self)>>>>>>>>>>>>>>>>>>>>")
    }
    
    let disposeBag = DisposeBag()
}
