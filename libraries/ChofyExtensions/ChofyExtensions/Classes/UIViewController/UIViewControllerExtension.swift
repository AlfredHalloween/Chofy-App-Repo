//
//  UIViewControllerExtension.swift
//  ChofyExtensions
//
//  Created by Juan Alfredo García González on 19/04/21.
//

import Foundation

public var appWindow: UIWindow? { return UIApplication.shared.delegate?.window ?? nil }

public var windowRootViewController: UIViewController? { return appWindow?.rootViewController }

public var windowTopViewController: UIViewController? {
    func finder(from viewController: UIViewController?) -> UIViewController? {
        if let tabBarViewController = viewController as? UITabBarController {
            return finder(from: tabBarViewController.selectedViewController)
        } else if let navigationController = viewController as? UINavigationController {
            return finder(from: navigationController.visibleViewController)
        } else if let presenterViewController = viewController?.presentedViewController {
            return finder(from: presenterViewController)
        } else {
            return viewController
        }
    }
    return finder(from: windowRootViewController)
}

public extension UIViewController {
    
    func setViewBackground(color: UIColor) {
        view.backgroundColor = color
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
