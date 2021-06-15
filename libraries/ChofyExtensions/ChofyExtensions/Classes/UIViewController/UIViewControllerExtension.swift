//
//  UIViewControllerExtension.swift
//  ChofyExtensions
//
//  Created by Juan Alfredo García González on 19/04/21.
//

import Foundation

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
