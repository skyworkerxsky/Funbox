//
//  DetailTableViewController.swift
//  FunboxStore
//
//  Created by Алексей Макаров on 20.01.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var numberTF: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: - Properties
    
    var currentDevice: DeviceModel!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEditScreen()
        
        titleTF.addTarget(self, action: #selector(changeValue), for: .editingChanged)
        priceTF.addTarget(self, action: #selector(changeValue), for: .editingChanged)
        numberTF.addTarget(self, action: #selector(changeValue), for: .editingChanged)
    }
    
    // MARK: - Selectors
    
    @objc func changeValue() {
        
        if titleTF.text?.isEmpty == false && priceTF.text?.isEmpty == false && numberTF.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    // MARK: - Functions
    
    func saveDevice() {
        
        let newDevice = DeviceModel(title: titleTF.text!, price: Int(priceTF.text!)!, number: Int(numberTF.text!)!)
        
        if currentDevice != nil {
            try! realm.write {
                currentDevice.title = newDevice.title
                currentDevice.price = newDevice.price
                currentDevice.number = newDevice.number
            }
        } else {
            StorageManager.saveObject(newDevice)
        }
    }
    
    private func setupEditScreen() {
        saveButton.isEnabled = false
        if currentDevice != nil {
            titleTF.text = currentDevice.title
            priceTF.text = "\(currentDevice.price)"
            numberTF.text = "\(currentDevice.number)"
        }
    }
    
    // MARK: - Actions
    
    @IBAction func canсelButtonPress(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
