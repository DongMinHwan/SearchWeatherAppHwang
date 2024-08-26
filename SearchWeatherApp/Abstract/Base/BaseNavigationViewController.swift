//
//  BaseNavigationViewController.swift
//  SearchWeatherApp
//
//  Created by 황동민 on 8/26/24.
//

import UIKit

class BaseNavigationViewController : UINavigationController {
     
     private var duringTransition = false
     private var disabledPopVCs : [UIViewController.Type] = []
     
     
     override func viewDidLoad() {
          super.viewDidLoad()
          setupNavigationBarAppearance()
          
          interactivePopGestureRecognizer?.delegate = self
          self.delegate = self
          
//          [MainViewController.self,
//           SearchViewController.self,
//          ].forEach {
//               self.disabledPopVCs.append($0)
//          }
     }
     
     private func setupNavigationBarAppearance() {
          let image = UIImage(named: "")
          let appearance = UINavigationBarAppearance()
          appearance.configureWithOpaqueBackground()
          appearance.backgroundColor = .LightSlateBlue
          appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
          appearance.setBackIndicatorImage(image, transitionMaskImage: image)
          appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear] // 백 버튼의 타이틀 숨김
          navigationBar.standardAppearance = appearance
          navigationBar.clipsToBounds = true
          navigationBar.isHidden = true
          
          
          // iOS 15...
          navigationBar.scrollEdgeAppearance = appearance
     }
}

extension BaseNavigationViewController: UINavigationControllerDelegate {
     func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
          self.duringTransition = false
     }
}

extension BaseNavigationViewController: UIGestureRecognizerDelegate {
     func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
          guard gestureRecognizer == interactivePopGestureRecognizer,
                let topVC = topViewController else {
               return true // default value
          }
          
          return viewControllers.count > 1 && duringTransition == false && isPopGestureEnable(topVC)
     }
     
     private func isPopGestureEnable(_ topVC: UIViewController) -> Bool {
          for vc in disabledPopVCs {
               if String(describing: type(of: topVC)) == String(describing: vc) {
                    return false
               }
          }
          return true
     }
}

extension UINavigationController {
     func pushToViewController(_ viewController: UIViewController, animated:Bool = true, completion: @escaping ()->()) {
          CATransaction.begin()
          CATransaction.setCompletionBlock(completion)
          self.pushViewController(viewController, animated: animated)
          CATransaction.commit()
     }
     
     func popViewController(animated:Bool = true, completion: @escaping ()->()) {
          CATransaction.begin()
          CATransaction.setCompletionBlock(completion)
          self.popViewController(animated: animated)
          CATransaction.commit()
     }
     
     func popToViewController(_ viewController: UIViewController, animated:Bool = true, completion: @escaping ()->()) {
          CATransaction.begin()
          CATransaction.setCompletionBlock(completion)
          self.popToViewController(viewController, animated: animated)
          CATransaction.commit()
     }
     
     func popToRootViewController(animated:Bool = true, completion: @escaping ()->()) {
          CATransaction.begin()
          CATransaction.setCompletionBlock(completion)
          self.popToRootViewController(animated: animated)
          CATransaction.commit()
     }
}


