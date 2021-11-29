//
//  OperationModel.swift
//  BCPChallenge
//
//  Created by Raul Quispe on 27/11/21.
//

import UIKit

struct OperationModel {
    var icon: UIImage!
    var title: String!
    var amount: String!
    var typeMoney: TypeCurrency!
    var rate: Double!
    init(titleText: String,
         amountText: String,
         typeMoney: TypeCurrency = .PEN,
         rate: Double) {
        self.icon = OperationModel.convertToImage(typeMoney: typeMoney)
        self.title = titleText
        self.amount = amountText
        self.typeMoney = typeMoney
        self.rate = rate
    }
    static func convertToImage(typeMoney: TypeCurrency) -> UIImage {
        var value: UIImage!
        switch typeMoney {
        case .EUR:
            value = Asset.MoneyFlag.europeanUnion.image
        case .USD:
            value = Asset.MoneyFlag.unitedStates.image
        case .JPY:
            value = Asset.MoneyFlag.japan.image
        case .GBP:
            value = Asset.MoneyFlag.unitedKingdom.image
        case .CHF:
            value = Asset.MoneyFlag.switzerland.image
        case .CAD:
            value = Asset.MoneyFlag.canada.image
        default:
            value = Asset.MoneyFlag.peru.image
        }
        return value
    }
}

