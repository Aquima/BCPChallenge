//
//  HomeMeliAPI.swift
//  BCPChallenge
//
//  Created by Raul on 17/11/21.
//

import Alamofire
typealias StackExchange = [MoneyRate]
protocol StackExchangeAPIProtocol {
    func getAuthToken(handler: @escaping (StackExchange?, ServerError?) -> Void )
}
class StackExchangeAPI: StackExchangeAPIProtocol {
    
    func getAuthToken(handler: @escaping (StackExchange?, ServerError?) -> Void) {
        let queue = DispatchQueue(label: "com.queue.concurrent",
                                  qos: .userInteractive,
                                  attributes: .concurrent)
        let semaphore = DispatchSemaphore(value: 1)
        queue.async {
            let apiManager = BCPApiManager.shared.sessionManager
            let urlRequest = URL(string: Configuration.urlStackExchange)!
            apiManager.request(urlRequest,
                               method: .get)
                .validate(statusCode: 200...299)
                .responseDecodable(of: StackExchange.self,
                                   queue: queue){ response in
                    guard let stackExchange = response.value else {
                        semaphore.signal()
                        DispatchQueue.main.async {
                            let code = response.response?.statusCode
                            if code == 401 {
                                let serverError = ServerError(rawValue: code!)
                                handler(nil,serverError)
                            }
                        }
                        return
                    }
                    semaphore.signal()
                    DispatchQueue.main.async {
                        handler(stackExchange,nil)
                    }
                  
                }
            semaphore.wait()
        }
     
    }
    
    
}
