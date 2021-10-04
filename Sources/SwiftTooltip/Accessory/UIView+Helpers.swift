//
//  File.swift
//  
//
//  Created by Dzmitry Arlou on 10/4/21.
//

import UIKit

extension UIView {
    
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
    
}
