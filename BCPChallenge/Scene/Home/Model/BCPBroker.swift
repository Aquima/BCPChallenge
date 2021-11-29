//
//  AGTBroker.swift
//  Quiz
//
//  Created by Raul Quispe on 26/11/21.
//

import UIKit

class BCPBroker: NSObject {
    
//    var rates: NSMutableDictionary!
//
//    init(_ rates: NSMutableDictionary) {
//        self.rates = rates
//    }
    
    private var rates: [AnyHashable : Any]?

    override init() {
            super.init()
                rates = [:]
    }
    
    func reduce(_ money: BCPMoney,
                toCurrency currency: TypeCurrency) throws -> BCPMoney?  {
        
        var result: BCPMoney?
        let fromCurrency = money.currency
        let rate: Double = ((rates![key(fromCurrency: fromCurrency,
                                        toCurrency: currency)] as? Double) ?? 0)

        if money.currency == currency {
            result = money
        } else if (rate == 0) {
//            let exception =  "Must \(money.currency) to \(currency)"
             throw Error.noRate
        } else {
            let newAmount = money.amount * rate
            result = BCPMoney.init(amount: newAmount, currency: currency)
        }
        return result
       
    }
    func addRate(_ rate: Double, fromCurrency: TypeCurrency, toCurrency: TypeCurrency) {
        rates?[key(fromCurrency: fromCurrency, toCurrency: toCurrency)] = rate
        let invRate = 1/rate
        rates?[key(fromCurrency: toCurrency, toCurrency: fromCurrency)] = invRate


    }
    func key(fromCurrency: TypeCurrency?, toCurrency: TypeCurrency?) -> String? {
        return "\(fromCurrency?.rawValue ?? "")-\(toCurrency?.rawValue ?? "")"
    }
}
enum Error: Swift.Error {
    case noRate
}
