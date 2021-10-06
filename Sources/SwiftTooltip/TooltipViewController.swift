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
    
    // MARK: - Init
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
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
    
}
