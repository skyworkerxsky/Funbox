//
//  Model.swift
//  FunboxStore
//
//  Created by Алексей Макаров on 20.01.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import RealmSwift

@objcMembers
class GadjetModel: Object {
    
    // MARK: - Properties
    dynamic var title: String
    dynamic var price: Int
    dynamic var Nubmber
}
