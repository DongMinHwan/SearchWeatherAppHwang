//
//  WindowManager.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import UIKit

class WindowManager {
    
    enum Path: String {
        case splash
        case main
        var vc: UIViewController {
            switch self {
            case .splash:
                return SplashViewController()
            case .main:

                
        //        data : 51.53167
        //        data : 4.22083
                var vc = MainViewController()
                vc.bind(viewModel: MainViewModel(lat: 36.783611
                                                 ,lon:127.004173,
                                                 service: WeatherService()))

                return BaseNavigationViewController(rootViewController: vc)
            }
        }
    }
    
    static func change(_ path: Path) {
        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            window.rootViewController = path.vc
        }
    }
}

