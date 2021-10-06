//
//  Bubble+BubbleView.swift
//  
//
//  Created by Anton Paliakou on 10/6/21.
//

import UIKit

public extension Bubble {
    
    final class BubbleView: UIView {
        
        // MARK: - Properties

        var alignment: CalloutAlignment = .left {
            didSet {
                backgroundView.alignment = alignment
            }
        }
        
        var config: Config = .default() {
            didSet {
                backgroundView.config = config
                updateAppearance()
            }
        }
        
        private let backgroundView = BackgroundView()
        
        private func updateAppearance() {
//            var stackMargin = stackView.layoutMargins
//            if config.calloutConfig.position == .up {
//                stackMargin.top += 12
//            } else {
//                stackMargin.bottom += 12
//            }
//
//            stackView.layoutMargins = stackMargin
        }
    }
}
