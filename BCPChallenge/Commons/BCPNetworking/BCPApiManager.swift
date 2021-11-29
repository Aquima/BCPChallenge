//
//  MeliApiManager.swift
//  BCPChallenge
//
//  Created by Raul on 10/11/21.
//

import Foundation
import Alamofire

class BCPApiManager: NSObject {
    static let shared = BCPApiManager()
    
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
            let userInfo = ["date": Date()]
            return CachedURLResponse(
                response: response.response,
                data: response.data,
                userInfo: userInfo,
                storagePolicy: .allowed)
        })
        
        let networkLogger = BCPNetworkLogger()
        let interceptor = BCPRequestInterceptor()
        
        return Session(configuration: configuration,
                       interceptor: interceptor,
                       cachedResponseHandler: responseCacher,
                       eventMonitors: [networkLogger])
    }()
}
