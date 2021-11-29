//
//  MoneyRate.swift
//  BCPChallenge
//
//  Created by Raul on 29/11/21.
//

import UIKit

class MoneyRate: Codable {
    let typeMoney: String
    let rate: Double
    func converToOperationModel()-> OperationModel {
        let typeCurrency = TypeCurrency(rawValue: typeMoney)
        let operationModel = OperationModel(titleText: ItemExchange.convertToString(typeMoney: typeCurrency!),
                                            amountText: "1 EURO == \(rate) \(typeCurrency!.rawValue)",
                                            typeMoney: typeCurrency!,
                                            rate: self.rate)
        return operationModel
    }
}
