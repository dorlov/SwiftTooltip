//
//  TooltipViewController+ViewModel.swift
//  
//
//  Created by Dzmitry Arlou on 10/6/21.
//

import UIKit

extension TooltipViewController {
    
    final class ViewModel {
            
        // MARK: - Properties
        
        var onShowNextTip: ((TooltipDesription) -> Void)?
        private var tooltips: [Tooltip]
        private let coordinator: TooltipCoordinator
                
        init(
            tooltips: [Tooltip],
            coordinator: TooltipCoordinator
        ) {
            self.tooltips = tooltips
            self.coordinator = coordinator
        }
        
        // MARK: - API
        
        func didTapTooltip() {
            guard let next = popNext() else {
                finish()
                return
            }
            
            onShowNextTip?(next)
        }
        
        // MARK: - Private
        
        private func popNext() -> TooltipDesription? {
            guard !tooltips.isEmpty else { return nil }
            return TooltipDesription(
                tooltip: tooltips.removeFirst()
            )
        }
        
        private func finish() {
            coordinator.finish()
        }
    }
    
    struct TooltipDesription {
        var tooltip: Tooltip
    }
    
}
