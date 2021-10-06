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
        
        var text: String? {
            didSet {
                setNeedsDisplay()
            }
        }
        
        var accessoryText: String? {
            didSet {
                setNeedsDisplay()
            }
        }
        
        private let backgroundView = BackgroundView()
        private lazy var textLabel = UILabel.multiLineLabel()
        private lazy var accessoryLabel = UILabel.multiLineLabel()
        private lazy var stackView = UIStackView(
            axis: .vertical, arrangedSubviews: [textLabel, accessoryLabel]
        )

        private lazy var anchorView: UIView = {
            let anchorView = UIView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            anchorView.makeSize(equalTo: CGSize(width: 1, height: 1))
            anchorView.backgroundColor = .clear
            return anchorView
        }()
        
        // MARK: - Init

        public init(alignment: CalloutAlignment) {
            self.alignment = alignment
            backgroundView.alignment = alignment
            super.init(frame: .zero)
            setupView()
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Overrides
        
        public override func removeFromSuperview() {
            anchorView.removeFromSuperview()
            super.removeFromSuperview()
        }
        
        // MARK: - Public

        public func showIn(_ holderView: UIView, highlightedView: UIView) {
            holderView.addSubview(self)
            self.translatesAutoresizingMaskIntoConstraints = false
            makeWidthLessThenOrEqualToSuperview(multipliedBy: 0.6)
            
            if config.calloutConfig.position == .up {
                putBelow(highlightedView, inset: -8)
            } else if config.calloutConfig.position == .down {
                putAbove(highlightedView, inset: -8)
            }
                            
            let sourcePoint = self.sourcePoint(for: highlightedView)
            
            holderView.addSubview(anchorView)
            anchorView
                .pinToLeft(inset: sourcePoint.x)
                .pinToBottom(inset: -sourcePoint.y)

            switch alignment {
            case .left:
                let leadingOffset = sourcePoint.x - config.calloutConfig.calloutSideOffset
                pinToLeft(inset: leadingOffset)
            case .center:
                centerHorizontally()
            case .right:
                self.rightAnchor.constraint(equalTo: anchorView.leftAnchor, constant: config.calloutConfig.calloutSideOffset).isActive = true
            case .custom(let offset):
                pinToLeft(inset: offset)
            }

        }
        
        // MARK: - Private
        
        private func setupView() {
            backgroundColor = .clear
            addSubview(backgroundView)
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.pinToSuperview()
            
            addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.pinToSuperview()
                    
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.layoutMargins = .init(top: 12, left: 12, bottom: 12, right: 12)
            stackView.spacing = 12
        }
        
        private func updateAppearance() {
            var stackMargin = stackView.layoutMargins
            if config.calloutConfig.position == .up {
                stackMargin.top += 12
            } else {
                stackMargin.bottom += 12
            }

            stackView.layoutMargins = stackMargin
        }
        
        private func sourcePoint(for highlightedView: UIView) -> CGPoint {
            switch config.calloutConfig.calloutViewPoint {
            case .center:
                return CGPoint(x: highlightedView.frame.midX, y: highlightedView.frame.minY)
            case .leading(let offset):
                return CGPoint(x: offset, y: highlightedView.frame.minY)
            }
        }
    }
}
