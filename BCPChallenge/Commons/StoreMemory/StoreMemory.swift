//
//  StoreMemory.swift
//  BCPChallenge
//
//  Created by Raul on 28/11/21.
//

import UIKit

class StoreMemory: NSObject {
    static var shared: StoreMemory = StoreMemory()
    var currentIndex: IndexPath?
    var currentSelectTypeMoney: TypeCurrency?
    var rate: Double?
    var amount: String?
}
