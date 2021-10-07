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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private
    
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
    
}

// MARK: - Helpers

extension UIView {
    
    func tooltipViews() -> [UIView] {
        var result: [UIView] = []

        for subview in subviews {
            result += subview.tooltipViews()
            
            if subview is TooltipView, subview.isHidden == false, subview.frame.height != CGFloat.zero {
                result.append(subview)
            }
        }
        
        return result
    }
    
}
