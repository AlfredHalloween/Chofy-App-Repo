//
//  ImageViewExtension.swift
//  ChofyExtensions
//
//  Created by Juan Alfredo García González on 17/04/21.
//

import Foundation
import SDWebImage

public extension UIImageView {
    
    func find(url: String, placeholder: UIImage? = nil) {
        guard let urlObject = URL(string: url) else {
            self.image = placeholder
            return
        }
        self.sd_setImage(with: urlObject, placeholderImage: placeholder)
    }
}
