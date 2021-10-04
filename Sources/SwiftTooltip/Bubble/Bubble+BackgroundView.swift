//
//  Bubble+CalloutAlignment.swift
//  
//
//  Created by Dzmitry Arlou on 10/2/21.
//

import UIKit

public extension Bubble {
    
    final class BackgroundView: UIView {
        
        // MARK: - Properties
        
        public var alignment: CalloutAlignment = .left {
            didSet { setNeedsDisplay() }
        }

        var config: Config = .default() {
            didSet { setNeedsDisplay() }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .clear
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public override func draw(_ rect: CGRect) {
            let path = UIBezierPath.bubblePath(with: config, alignment: alignment, inBounds: bounds)

            config.fillColor.setFill()
            path.fill()

            config.strokeColor.setStroke()
            path.lineWidth = config.lineWidth
            path.stroke()
            
            if config.calloutConfig.position == .up {
                rotate(angle: 180)
            }
        }

    }
    
}
