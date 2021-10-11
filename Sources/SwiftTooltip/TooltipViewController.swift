//
//  File.swift
//  
//
//  Created by Dzmitry Arlou on 10/6/21.
//

import UIKit

final class TooltipViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: ViewModel
    private weak var presenterView: UIView?
    private var currentBubbleView: Bubble.BubbleView?
    private var currentHighlightedView: UIImageView?
    private var initialScrollContentOffset = CGPoint.zero
    private lazy var tooltipViews: [UIView] = {
        self.presenterView?.tooltipViews() ?? []
    }()
    
    // MARK: - Init
    
    init(viewModel: ViewModel, presenterView: UIView?) {
        self.viewModel = viewModel
        self.presenterView = presenterView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupViews()
        bindViewModel()
    }
    
    // MARK: - Private
    
    private func setupViews() {
        // to connect background from Tips Config
    }
    
    private func bindViewModel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(tapGesture)
        
        viewModel.onShowNextTip = { [weak self] in self?.showNextTooltip($0) }
    }
    
    @objc private func didTapView() {
        viewModel.didTapTooltip()
    }
    
    private func showNextTooltip(_ tooltipDescription: TooltipDesription) {
        currentBubbleView?.removeFromSuperview()
        currentHighlightedView?.removeFromSuperview()
    }
    
    private func tooltipView(for tooltip: Tooltip) -> UIView? {
        for subview in tooltipViews {
            if let tooltipView = subview as? TooltipHighlightedView, tooltipView.tooltip.id == tooltip.id {
                return subview
            }
        }
        return nil
    }
    
    private func targetScrollContentOffset(forConvertedFrame convertedFrame: CGRect) -> CGPoint? {
        guard let scrollView = self.tipsScrollView else { return nil }
        
        if !view.safeAreaLayoutGuide.layoutFrame.contains(convertedFrame) {
            let isConvertedFrameOutOfTop = (convertedFrame.origin.y - scrollView.contentOffset.y) < self.view.safeAreaInsets.top

            if convertedFrame.origin.y < 0 || isConvertedFrameOutOfTop {
                return initialScrollContentOffset
            } else {
                var currentOffset = scrollView.contentOffset
                currentOffset.y += convertedFrame.maxY - self.view.safeAreaLayoutGuide.layoutFrame.height
                return currentOffset
            }
        }
        
        let isFrameInTopScreenBounds = convertedFrame.origin.y < view.safeAreaLayoutGuide.layoutFrame.height / 2
        if (scrollView.contentOffset.y > 0) && isFrameInTopScreenBounds {
            return initialScrollContentOffset
        }
        
        return nil
    }

    
    private func convertedFrame(for tooltipView: UIView, completion: @escaping (CGRect?) -> Void) {
        guard var convertedFrame = tooltipView.superview?.convert(tooltipView.frame, to: view) else {
            completion(nil)
            return
        }
        
        if let newContentOffset = targetScrollContentOffset(forConvertedFrame: convertedFrame) {
            self.tipsScrollView?.setContentOffset(
                newContentOffset,
                animated: true
            ) {
                convertedFrame = tooltipView.superview?.convert(tooltipView.frame, to: self.view) ?? convertedFrame
                completion(convertedFrame)
            }
            
        } else {
            completion(convertedFrame)
        }

    }
    
    private var tipsScrollView: UIScrollView? {
        presenterView?.subviews.first as? UIScrollView
    }
    
}

// MARK: - Helpers

extension UIView {
    
    func tooltipViews() -> [UIView] {
        var result: [UIView] = []

        for subview in subviews {
            result += subview.tooltipViews()
            
            if subview is TooltipHighlightedView, subview.isHidden == false, subview.frame.height != CGFloat.zero {
                result.append(subview)
            }
        }
        
        return result
    }
    
}
