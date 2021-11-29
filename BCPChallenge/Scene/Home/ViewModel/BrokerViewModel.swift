//
//  BrokerViewModel.swift
//  BCPChallenge
//
//  Created by Raul on 29/11/21.
//

import Foundation
protocol BrokerViewModelDelegate: AnyObject {
    func reduceUpdate(_ data: [ItemExchange])
}
struct BrokerViewModel {
    var delegate: BrokerViewModelDelegate?
    init() {
        StoreMemory.shared.amount = "0.0"
        StoreMemory.shared.currentSelectTypeMoney = .USD
        StoreMemory.shared.rate = 1.0963
    }
    func reduce(_ items: [ItemExchange]) {
        var data = items
        let broker = BCPBroker()
        guard let rate = StoreMemory.shared.rate,
            let toCurrency = data.last?.typeMoney,
            let fromCurrency = data.first?.typeMoney else {
           return
        }
        broker.addRate(rate,
                       fromCurrency: fromCurrency,
                       toCurrency: toCurrency)
        guard let fromAmount = StoreMemory.shared.amount else {
            return
        }
        let sendMoney = BCPMoney(amount: Double(fromAmount)!,
                                 currency: fromCurrency)
        do {
            let newMoney = try broker.reduce(sendMoney, toCurrency: toCurrency)
            print("el nuevo monto: \(String(describing: newMoney?.amount))")
            data[0].amount = fromAmount
            if let newCurrency = StoreMemory.shared.currentSelectTypeMoney {
                data[0].typeMoney = newCurrency
            }
            data[1].amount = String(newMoney!.amount)
            self.delegate?.reduceUpdate(data)
            
        }catch let error {
            print(error)
        }
    }
}
