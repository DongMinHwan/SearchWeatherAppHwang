//
//  SplashViewController.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import UIKit

class SplashViewController: BaseViewController {
   
    let mainView = SplashView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            WindowManager.change(.main)
        }
    }
}
