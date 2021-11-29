//
//  AGTMoneyTests.swift
//  QuizTests
//
//  Created by Raul Quispe on 25/11/21.
//

import XCTest
@testable import BCPChallenge
class AGTMoneyTests: XCTestCase {

    func testCurrency() {
        XCTAssertLessThanOrEqual("EUR", BCPMoney.euro(1).currency.rawValue, "The currency of euros should be EUR")
        
        XCTAssertLessThanOrEqual("USD", BCPMoney.dollar(1).currency.rawValue, "The currency of euros should be usd")
    }
    
    func testMultiplication() {
        let euro: BCPMoney = BCPMoney.euro(5)
        let ten: BCPMoney = BCPMoney.euro(10)
        let total: BCPMoney = euro.times(2)
        XCTAssertEqual(total, ten, "ambas cantidades deben ser iguales")
    }
    
    func testEquality() {
        let five: BCPMoney = BCPMoney.euro(5)
        let ten: BCPMoney = BCPMoney.euro(10)
        let total: BCPMoney = five.times(2)
        XCTAssertEqual(ten, total, "ambas cantidades deben ser iguales")
        XCTAssertEqual(BCPMoney.dollar(4), BCPMoney.dollar(2).times(2), "Ambos deben ser iguales")
    }
    func testHash() {
        let a = BCPMoney.euro(2)
        let b = BCPMoney.euro(2)
        XCTAssertEqual(a.hash(), b.hash(), "Ambos objetos deben tener el mismo hash")
        XCTAssertEqual(BCPMoney.dollar(1).hash(), BCPMoney.dollar(1).hash(), "Ambos objetos deben tener el mismo hash")
    }
    func testAmountStorage() {
        let euro = BCPMoney.euro(2)
        XCTAssertEqual(2, euro.amount, "El valor debe ser el mismo")
    }
    func testDifferentCurrencies() {
        let euro = BCPMoney.euro(1)
        let dollar = BCPMoney.dollar(1)
        XCTAssertNotEqual(euro, dollar, "Different currencies should be not equal")
    }
    func testSimpleAddition() {
        XCTAssertEqual(BCPMoney.dollar(5).plus(BCPMoney.dollar(5)), BCPMoney.dollar(10), "$5 + $5 = $10")
    }
    func testThatHashIsAmount() {
        let one = BCPMoney.dollar(1)
        XCTAssertEqual(one.hash(), 1, "The hash must be the same as the amount")
    }
    func testDescription() {
        let one = BCPMoney.dollar(1)
        let desc = "<BCPMoney: USD 1.0>"
        XCTAssertEqual(desc, one.description(), "Description must match template")
    }
}

