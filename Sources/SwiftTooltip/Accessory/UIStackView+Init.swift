//
//  UIStackView+Factory.swift
//  
//
//  Created by Anton Paliakou on 10/6/21.
//

import UIKit

extension UIStackView {

    convenience init(axis: NSLayoutConstraint.Axis = .horizontal, arrangedSubviews: [UIView]) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }    
}
