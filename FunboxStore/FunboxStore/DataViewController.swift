//
//  DataViewController.swift
//  FunboxStore
//
//  Created by Алексей Макаров on 21.02.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    
    // MARK: - Properties
    
    var text: String?
    var index: Int?

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = text
    }


}
