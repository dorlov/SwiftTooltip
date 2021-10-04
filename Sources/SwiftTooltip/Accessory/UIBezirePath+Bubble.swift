//
//  File.swift
//  
//
//  Created by Dzmitry Arlou on 10/4/21.
//

import UIKit

extension UIBezierPath {

    static func bubblePath(
        with config: Bubble.Config,
        alignment: Bubble.CalloutAlignment,
        inBounds bounds: CGRect
    ) -> UIBezierPath {
        let lineWidth = config.lineWidth
        let cornerRadius = config.cornerRadius
        let calloutSize = config.calloutSize

        let rect = bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
        let path = UIBezierPath()

        // lower left corner
        path.move(to: CGPoint(x: rect.minX + config.cornerRadius, y: rect.maxY - calloutSize.height))
        path.addQuadCurve(
            to: CGPoint(x: rect.minX, y: rect.maxY - calloutSize.height - cornerRadius),
            controlPoint: CGPoint(x: rect.minX, y: rect.maxY - calloutSize.height)
        )

        // left
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))

        // upper left corner
        path.addQuadCurve(
            to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY),
            controlPoint: CGPoint(x: rect.minX, y: rect.minY)
        )

        // top
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))

        // upper right corner
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.minY + cornerRadius),
            controlPoint: CGPoint(x: rect.maxX, y: rect.minY)
        )

        // right
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - calloutSize.height - cornerRadius))

        // lower right corner
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - calloutSize.height),
            controlPoint: CGPoint(x: rect.maxX, y: rect.maxY - calloutSize.height)
        )

        // bottom (including callout)
        let calloutConfig = config.calloutConfig
        
        let calloutX: CGFloat
        switch calloutConfig.bezierCalloutAlignment {
        case .center:
            calloutX = rect.midX
        case .left: calloutX = calloutConfig.calloutSideOffset
        case .right: calloutX = rect.maxX - calloutConfig.calloutSideOffset
        case .custom(let offset): calloutX = offset
        }

        path.addLine(to: CGPoint(x: calloutX + calloutSize.width, y: rect.maxY - calloutSize.height))
        path.addLine(to: CGPoint(x: calloutX + cornerRadius / 2, y: rect.maxY - cornerRadius / 2))
        path.addQuadCurve(
            to: CGPoint(x: calloutX, y: rect.maxY),
            controlPoint: CGPoint(x: calloutX, y: rect.maxY)
        )

        path.addLine(to: CGPoint(x: calloutX - calloutSize.width, y: rect.maxY - calloutSize.height))
        path.close()
        return path
    }

}

private extension Bubble.CalloutConfig {
    
    var bezierCalloutAlignment: Bubble.CalloutAlignment {
        switch alignment {
        case .center: return .center
        case .left: return position == .down ? .left : .right
        case .right: return position == .down ? .right : .left
        case .custom(let value): return .custom(value)
        }
    }
    
}

