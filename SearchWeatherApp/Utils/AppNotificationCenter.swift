//
//  AppNotification.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/28/24.
//
import Foundation
import RxCocoa
import RxSwift

protocol NotificationCenterProtocol {
    var name: Notification.Name { get }
}


extension NotificationCenterProtocol {
    func addObserver() -> Observable<Any?> {
        return NotificationCenter.default.rx.notification(self.name).map { $0.object }
    }
    
    func post(object: Any? = nil) {
        NotificationCenter.default.post(name: self.name, object: object)
    }
}


enum SearchNotificationCenter : NotificationCenterProtocol {
    case coordinate
    
    var name : Notification.Name {
        switch self {
        case .coordinate:
            return Notification.Name("SearchNotificationCenter.coordinate")
      
        }
    }
}
