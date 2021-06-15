//
//  ViewExtension.swift
//  ChofyExtensions
//
//  Created by Juan Alfredo García González on 18/04/21.
//

import Foundation

public extension UIView {
    
    func addAndFit(subview: UIView) {
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        subview.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func roundedView() {
        self.layer.cornerRadius = self.bounds.height / 2
        self.clipsToBounds = true
    }
}
