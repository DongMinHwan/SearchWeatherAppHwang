//
//  BaseViewController.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {

    var disposeBag = DisposeBag()
    deinit {
        print(">>>>>>>>>>>>>\(Self.self) End >>>>>>>>>>>>>>>>>>>.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func initialize() {
        
    }


}
