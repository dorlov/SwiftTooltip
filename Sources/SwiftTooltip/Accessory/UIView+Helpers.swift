//
//  UIView+Helpers.swift
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
    
    func captureImage() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: frame.size)
        return renderer.image { _ in drawHierarchy(in: bounds, afterScreenUpdates: true) }
    }
    
}

extension UIScrollView {
    
    func setContentOffset(_ offset: CGPoint, animated: Bool, completion: @escaping () -> Void) {
        guard animated else {
            contentOffset = offset
            return
        }
        
        UIView.animate(
            withDuration: 0.3,
            animations: { self.contentOffset = offset },
            completion: { _ in
                completion()
            })
    }

}
