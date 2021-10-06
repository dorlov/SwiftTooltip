//
//  File.swift
//  
//
//  Created by Dzmitry Arlou on 10/6/21.
//

import UIKit

protocol TooltipCoordinator {
    
    func finish()
    
}

final class TooltipCoordinatorDefault: TooltipCoordinator {
    
    private weak var presenterVC: UIViewController?
    private weak var rootVC: UIViewController?
    private var onFinish: (() -> Void)?
    
    init(presenterVC: UIViewController?) {
        self.presenterVC = presenterVC
    }
    
    func start(
        with tooltips: [Tooltip],
        onFinish: (() -> Void)?
    ) {
        self.onFinish = onFinish
        let tooltipVC = TooltipViewController()
        self.rootVC = tooltipVC
        tooltipVC.modalPresentationStyle = .custom
        
        presenterVC?.present(tooltipVC, animated: false, completion: nil)
    }
        
    func finish() {
        rootVC?.dismiss(animated: false, completion: { [weak self] in
            self?.onFinish?()
        })
    }
    
}