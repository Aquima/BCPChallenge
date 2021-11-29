//
//  DoubleModifiers.swift
//  BCPChallenge
//
//  Created by Raul on 29/11/21.
//

import UIKit

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
