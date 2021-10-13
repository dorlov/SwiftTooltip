//
//  SwiftTooltip.swift
//  
//
//  Created by Dzmitry Arlou on 10/4/21.
//

import UIKit

public struct TooltipItem: Identifiable {
    
    public var id: String = UUID().uuidString
    public var message: String
    public var calloutConfig: Bubble.CalloutConfig
    
    public init(
        id: String = UUID().uuidString,
        message: String,
        calloutConfig: Bubble.CalloutConfig
    ) {
        self.id = id
        self.message = message
        self.calloutConfig = calloutConfig
    }
    
}

public protocol TooltipHighlightedView {
    
    var tooltip: TooltipItem { get }
    
}

public final class Tooltips {
    
    public static func show(
        _ tooltips: [TooltipItem],
        in presenterVC: UIViewController?,
        completion: (() -> Void)?
    ) {
        let coordinator = TooltipViewController.Coordinator(presenterVC: presenterVC)
        coordinator.start(with: tooltips, onFinish: completion)
    }
    
    
}
