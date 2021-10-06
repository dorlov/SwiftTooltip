//
//  View+PinAnchor.swift
//  
//
//  Created by Anton Paliakou on 10/6/21.
//

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

#if os(iOS)
    public typealias PinView = UIView
#elseif os(OSX)
    public typealias PinView = NSView
#endif

// MARK: - PinAnchor extensions for UIView/NSView

extension PinView {
    
    // MARK: - Metric Constraints
    
    @discardableResult
    func pinToTop(inset: CGFloat = .zero) -> PinView {
        self.topAnchor.constraint(equalTo: self.parent.topAnchor, constant: inset).isActive = true
        return self
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func pinToTopSafeArea(inset: CGFloat = .zero) -> PinView {
        self.topAnchor.constraint(equalTo: self.parent.safeAreaLayoutGuide.topAnchor, constant: inset).isActive = true
        return self
    }
    
    @discardableResult
    func pinToLeft(inset: CGFloat = .zero) -> PinView {
        self.leadingAnchor.constraint(equalTo: self.parent.leadingAnchor, constant: inset).isActive = true
        return self
    }
    
    @discardableResult
    func pinToRight(inset: CGFloat = .zero) -> UIView {
        self.trailingAnchor.constraint(equalTo: self.parent.trailingAnchor, constant: -inset).isActive = true
        return self
    }
    
    @discardableResult
    func pinToBottom(inset: CGFloat = .zero) -> PinView {
        self.bottomAnchor.constraint(equalTo: self.parent.bottomAnchor, constant: -inset).isActive = true
        return self
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func pinToBottomSafeArea(inset: CGFloat = .zero) -> PinView {
        self.bottomAnchor.constraint(equalTo: self.parent.safeAreaLayoutGuide.bottomAnchor, constant: inset).isActive = true
        return self
    }
    
    @discardableResult
    func putBelow(_ aboveView: UIView, inset: CGFloat = .zero) -> UIView {
        self.topAnchor.constraint(equalTo: aboveView.bottomAnchor, constant: inset).isActive = true
        return self
    }
    
    @discardableResult
    func putAbove(_ belowView: UIView, inset: CGFloat = .zero) -> UIView {
        self.bottomAnchor.constraint(equalTo: belowView.topAnchor, constant: inset).isActive = true
        return self
    }
    
    // MARK: - Width Constraints
    
    @discardableResult
    func makeWidth(_ width: CGFloat) -> PinView {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func makeMaxWidth(_ width: CGFloat) -> PinView {
        self.widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func makeMinWidth(_ width: CGFloat) -> PinView {
        self.widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func makeWidthLessThenOrEqualToSuperview(multipliedBy amount: CGFloat = 0) -> UIView {
        if amount > 0 {
            self.widthAnchor.constraint(greaterThanOrEqualTo: self.parent.widthAnchor, multiplier: amount).isActive = true
        } else {
            self.widthAnchor.constraint(lessThanOrEqualTo: self.parent.widthAnchor).isActive = true
        }
        return self
    }
    
    // MARK: - Height Constraints
    
    @discardableResult
    func makeHeight(_ height: CGFloat) -> PinView {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func makeMaxHeight(_ height: CGFloat) -> PinView {
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func makeMinHeight(_ height: CGFloat) -> PinView {
        self.heightAnchor.constraint(lessThanOrEqualToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func makeSize(equalTo size: CGSize) -> UIView {
        makeHeight(size.height)
        makeWidth(size.width)
        return self
    }
    
    @discardableResult
    func pinToSuperview(insets: UIEdgeInsets = .zero) -> UIView {
        pinToTop(inset: insets.top)
        pinToLeft(inset: insets.left)
        pinToRight(inset: insets.right)
        pinToBottom(inset: insets.bottom)
        return self
    }
    
    // MARK: - Center to parent Constraints
    
    @discardableResult
    func centerVertically(offset: CGFloat = .zero) -> PinView {
        self.centerYAnchor.constraint(equalTo: self.parent.centerYAnchor, constant: offset).isActive = true
        return self
    }
    
    @discardableResult
    func centerHorizontally(offset: CGFloat = .zero) -> PinView {
        self.centerXAnchor.constraint(equalTo: self.parent.centerXAnchor, constant: offset).isActive = true
        return self
    }
    
    @discardableResult
    func centerInSuperview() -> PinView {
        self
            .centerVertically()
            .centerHorizontally()
        return self
    }
}

// MARK: - Private extensions

private extension PinView {
    
    var parent: PinView {
        guard let parent = self.superview else {
            fatalError("Expected superview but found nil")
        }
        return parent
    }
}
