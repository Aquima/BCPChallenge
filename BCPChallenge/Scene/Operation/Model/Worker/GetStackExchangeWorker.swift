//
//  GetAuthTokenWorker.swift
//  BCPChallenge
//
//  Created by Raul on 17/11/21.
//
import Foundation
import UIKit
typealias StackExchangeUI = [OperationModel]
protocol GetStackExchangeWorkerProtocol {
    func getAuthToken(_ handler: @escaping (StackExchangeUI?, MessageError?) -> Void )
}
class GetStackExchangeWorker: GetStackExchangeWorkerProtocol {
    let api: StackExchangeAPIProtocol
    /// Can be setted in the tests
    var reachability: ReachabilityCheckingProtocol
    let maxNumberOfAttempts = 3
    var currentNumberOfAttempts = 0
    init(
        _ api: StackExchangeAPIProtocol = StackExchangeAPI(),
        _ reachability: ReachabilityCheckingProtocol = Reachability()
    ) {
        self.api = api
        self.reachability = reachability
    }
    func getAuthToken(_ handler: @escaping (StackExchangeUI?, MessageError?) -> Void ) {
        guard reachability.isConnectedToNetwork() && currentNumberOfAttempts != maxNumberOfAttempts else {
            handler(nil, nil)
            return
        }
        currentNumberOfAttempts += 1
        api.getAuthToken(handler: { stackExchange, error in
            if let error = error {
                debugPrint(error)
                self.getAuthToken(handler)
                let messageError = MessageError(serverError: error)
                handler(nil,messageError)
            }
            var stackExchangeUI = StackExchangeUI()
            for item in stackExchange! {
                stackExchangeUI.append(item.converToOperationModel())
            }
            handler(stackExchangeUI, nil)
        })
    }
}
