//
//  TooltipViewController+ViewModel.swift
//  
//
//  Created by Dzmitry Arlou on 10/6/21.
//

import UIKit

final class TooltipViewModel: TooltipViewModelInput {
        
    // MARK: - Properties
    
    var onShowNextTip: ((TooltipDesription) -> Void)?
    private var tooltips: [Tooltip]
            
    init(tooltips: [Tooltip]) {
        self.tooltips = tooltips
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
        
    }
}



protocol TooltipViewModelInput {
    func didTapTooltip()
}

extension TooltipViewModel {
    
    struct TooltipDesription {
        var tooltip: Tooltip
    }
    
}
