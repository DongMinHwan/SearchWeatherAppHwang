//
//  Extension+UIViewController.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import Foundation
import UIKit


extension UIViewController {
    func pushVC(_ vc : UIViewController , animated: Bool = true) {
        
        self.navigationController?.pushViewController(vc, animated: animated)
    }
    
    func popViewController() {
        
       self.navigationController?.popViewController(animated: true)
    }
    
}
