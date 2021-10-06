//
//  UILabel+Factory.swift
//  
//
//  Created by Anton Paliakou on 10/6/21.
//

import UIKit

extension UILabel {
    
    static func multiLineLabel(numberOfLines: Int = 0) -> UILabel {
        let label = UILabel()
        label.numberOfLines = numberOfLines
        return label
    }
}
