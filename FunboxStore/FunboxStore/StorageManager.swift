//
//  StorageManager.swift
//  FunboxStore
//
//  Created by Алексей Макаров on 20.01.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    // Save
    static func saveObject(_ device: DeviceModel) {
        try! realm.write {
            realm.add(device)
        }
    }
    
    // Delete
    static func deleteObject (_ device: DeviceModel) {
        try! realm.write {
            realm.delete(device)
        }
    }
    
}
