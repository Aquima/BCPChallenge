//
//  AGTMoney.swift
//  Quiz
//
//  Created by Raul Quispe on 25/11/21.
//

import Foundation

class BCPMoney: Equatable {
    
    var currency: TypeCurrency!
    var amount: Double!
    init(amount: Double, currency: TypeCurrency){
        self.amount = amount
        self.currency = currency
    }
    class func euro(_ amount: Double) -> BCPMoney {
        return BCPMoney.init(amount: amount, currency: .EUR)
    }
    class func dollar(_ amount: Double) -> BCPMoney {
        return BCPMoney.init(amount: amount, currency: .USD)
    }
    static func == (lhs: BCPMoney, rhs: BCPMoney) -> Bool {
        if lhs.currency == rhs.currency {
            return lhs.amount == rhs.amount
        } else {
            return false
        }
    }
    func plus(_ other: BCPMoney) -> BCPMoney {
        let totalAmount = self.amount + other.amount
        let total = BCPMoney.init(amount: totalAmount, currency: self.currency)
        return total
    }
    func times(_ times: Int) -> BCPMoney {
        let newMoney: BCPMoney = BCPMoney.init(amount: self.amount * Double(times), currency: self.currency)
        return newMoney
    }
    func description() -> String {
        return "<\(type(of: self)): \(currency!) \(amount!)>"
    }
    func hash() -> Int {
        return Int(amount)
    }
}
