//
//  StackExchangeViewModel.swift
//  BCPChallenge
//
//  Created by Raul on 29/11/21.
//

import Foundation
protocol StackExchangeViewModelDelegate: AnyObject {
    func updateList(data:StackExchangeUI)
}
struct StackExchangeViewModel {
    var delegate: StackExchangeViewModelDelegate? = nil
    func getStackExchange(){
        let worker = GetStackExchangeWorker()
        worker.getAuthToken({stackExchange, error in
            guard let stackExchangeUI = stackExchange else {
                
                return
            }
            delegate?.updateList(data: stackExchangeUI)
        })
    }
}
