//
//  MeliRequestInterceptor.swift
//  BCPChallenge
//
//  Created by Raul on 10/11/21.
//

import Foundation
import Alamofire

class BCPRequestInterceptor: RequestInterceptor {
    let retryLimit = 3
    let retryDelay: TimeInterval = 10
    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.setValue("Content-Type", forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        let response = request.task?.response as? HTTPURLResponse
        if let statusCode = response?.statusCode,(500...599).contains(statusCode), request.retryCount < retryLimit {
            completion(.retryWithDelay(retryDelay))
        }else{
            return completion(.doNotRetry)
        }
    }
}
