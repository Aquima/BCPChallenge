//
//  AGTBrokerTests.swift
//  QuizTests
//
//  Created by Raul Quispe on 26/11/21.
//

import XCTest
@testable import BCPChallenge
class AGTBrokerTests: XCTestCase {

    var emptyBroker: BCPBroker!
    var oneDollar: BCPMoney!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        emptyBroker = BCPBroker()
        oneDollar = BCPMoney.dollar(1)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        emptyBroker = nil
        oneDollar = nil
    }
    
    func testSimpleReduction() {
        let sum: BCPMoney = BCPMoney.dollar(5).plus(BCPMoney.dollar(5))
        do {
            let reduced = try self.emptyBroker.reduce(sum, toCurrency: .USD)
            XCTAssertEqual(sum, reduced, "Conversion to same currency should be a not")
        } catch let error {
            print(error)
        }
       
    }
    func testReductionUSDtoEUR() {
        emptyBroker.addRate(2.0, fromCurrency: .USD, toCurrency: .EUR)
        let dollars = BCPMoney.dollar(5)
        let euros = BCPMoney.euro(10)
        do {
            let converted = try emptyBroker.reduce(dollars, toCurrency: .EUR)
            XCTAssertEqual(converted, euros, "$€5 == $10 1:2")
        } catch let error {
            print(error)
        }
    
    }
    func testReductionEURtoUSD() {
        emptyBroker.addRate(2.0, fromCurrency: .EUR, toCurrency: .USD)
        let dollars = BCPMoney.dollar(10)
        let euros = BCPMoney.euro(5)
        do {
            let converted = try emptyBroker.reduce(dollars, toCurrency: .EUR)
            XCTAssertEqual(converted, euros, "€5 == $10 1:2")
        } catch let error {
            print(error)
        }
    }
    func testReductionPENtoJPY() {
        emptyBroker.addRate(28.10, fromCurrency: .JPY, toCurrency: .PEN)
        let sol = BCPMoney.init(amount: 56.20, currency: .PEN)
        let jpy = BCPMoney.init(amount: 2, currency: .JPY)
        do {
            let converted = try emptyBroker.reduce(sol, toCurrency: .JPY)
            XCTAssertEqual(converted, jpy, "1.42PEN == 40JPY 1:28.19")
        } catch let error {
            print(error)
        }
    }
    func testReductionPENtoUSD() {
        emptyBroker.addRate(2, fromCurrency: .USD, toCurrency: .PEN)
        let sol = BCPMoney.init(amount: 20, currency: .PEN)
        let jpy = BCPMoney.init(amount: 10, currency: .USD)
        do {
            let converted = try emptyBroker.reduce(sol, toCurrency: .USD)
            XCTAssertEqual(converted, jpy, "20PEN == 10USD 1:28.19")
        } catch let error {
            print(error)
        }
    }
    func testThatNoRateRaisesException() throws {
        XCTAssertThrowsError(try emptyBroker.reduce(oneDollar, toCurrency: .EUR), "No rates should case exception")
    }
    func testThatNilConversionDoesNotChangeMoney() {
        XCTAssertEqual(oneDollar, try emptyBroker.reduce(oneDollar, toCurrency: .USD), "A nil coversion should have no effect")
    }

}
