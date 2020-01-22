//
//  SldieViewController.swift
//  FunboxStore
//
//  Created by Алексей Макаров on 22.01.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import UIKit

class SlideViewController: UIViewController {

    // MARK: - UI
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subView: [UIView] = [self.label]
    
    // MARK: - Init
    
    init(slideWith: SlideHelper) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .purple
        edgesForExtendedLayout = []
        
        label.text = slideWith.name
        
        for view in subView {
            self.view.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
