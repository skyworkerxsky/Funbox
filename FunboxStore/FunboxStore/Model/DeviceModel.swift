//
//  Model.swift
//  FunboxStore
//
//  Created by Алексей Макаров on 20.01.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import RealmSwift

@objcMembers
class DeviceModel: Object {
    
    // MARK: - Properties
    
    dynamic var deviceID = UUID().uuidString
    dynamic var title: String = ""
    dynamic var price: Int = 0
    dynamic var number: Int = 0
    
    // MARK: - Init
    
    convenience init(title: String, price: Int, number: Int){
        self.init()
        
        self.title = title
        self.price = price
        self.number = number
    }
    
    // MARK: - Functions
    
    override static func primaryKey() -> String? {
        return "deviceID"
    }
    
    static func createTest() {
        var count = 0
        for _ in 1...5 {
            
            let newDevice = DeviceModel(title: "Samsung s\(count)", price: 8999 + (count * 100), number: 3 + count)
            count += 1
            StorageManager.saveObject(newDevice)
        }
    }
    
}
