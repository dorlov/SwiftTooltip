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
    func makeWidth(_ width: CGFloat = .zero) -> PinView {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func makeHeight(_ height: CGFloat = .zero) -> PinView {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
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
