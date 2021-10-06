//
//  SwiftTooltip.swift
//  
//
//  Created by Dzmitry Arlou on 10/4/21.
//

import UIKit

struct Tooltip: Identifiable {
    
    var id: String = UUID().uuidString
    var message: String
    var calloutConfig: Bubble.CalloutConfig
    
}

protocol TooltipHighlightedView {
    
    var tooltip: Tooltip { get }
    
}

