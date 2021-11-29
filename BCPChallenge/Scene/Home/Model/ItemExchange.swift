//
//  HomeModel.swift
//  BCPChallenge
//
//  Created by Raul Quispe on 27/11/21.
//

import UIKit
enum TypeCurrency:String, CaseIterable {
    case EUR = "EUR"
    case USD = "USD"
    case JPY = "JPY"
    case GBP = "GBP"
    case CHF = "CHF"
    case CAD = "CAD"
    case PEN = "PEN"
}
struct ItemExchange {
    var title: String!
    var amount: String!
    var typeMoney: TypeCurrency = .PEN
    init(_ title: String,
         _ amount: String,
         _ typeMoney: TypeCurrency) {
        self.title = title
        self.amount = amount
        self.typeMoney = typeMoney
    }
   
    static func convertToString(typeMoney: TypeCurrency) -> String {
        var value: String!
        switch typeMoney {
        case .EUR:
            value = "EURO"
        case .USD:
            value = "DOLAR"
        case .JPY:
            value = "YEN"
        case .GBP:
            value = "LIBRA ESTERLINA"
        case .CHF:
            value = "FRANCO SUIZO"
        case .CAD:
            value = "DOLAR CANADIENSE"
        default:
            value = "SOLES"
        }
        return value
    }
    
}
