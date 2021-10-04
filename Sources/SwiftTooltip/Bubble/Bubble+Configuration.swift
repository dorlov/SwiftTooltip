//
//  Bubble+Configuration.swift
//  
//
//  Created by Dzmitry Arlou on 10/2/21.
//

import UIKit

public extension Bubble {

    enum CalloutAlignment {
        case
        left,
        center,
        right,
        custom(CGFloat)
    }

}

public extension Bubble {
    
    struct Config {
        let lineWidth: CGFloat
        let cornerRadius: CGFloat
        let calloutSize: CGSize
    }
    
    struct CalloutConfig {
        var alignment: CalloutAlignment
        var position: SourcePosition
        var calloutSideOffset: CGFloat = 30
        var calloutViewPoint: CalloutViewPoint = .center
        
        static var `default`: Self {
            Self(alignment: .left, position: .down)
        }
    }
    
    enum SourcePosition {
        case up, down
    }
    
    /// Defines the position of a callout of the bubble that touches the highlighted tooltip view
    enum CalloutViewPoint {
        
        /// By default it is center that means bubble will be pointing in the middle of the View's X
        case center
        
        /// Callout will be pointing to the leading offset of the tooltip view
        case leading(CGFloat)
    }
    
}
