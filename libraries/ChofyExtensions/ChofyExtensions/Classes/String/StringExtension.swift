//
//  StringExtension.swift
//  ChofyExtensions
//
//  Created by Juan Alfredo García González on 17/04/21.
//

import Foundation

public extension String {
    func height(with constrainedWidth: CGFloat, font: UIFont) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: constrainedWidth, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.height
    }
}
