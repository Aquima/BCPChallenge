//
//  MeliNetworkLogger.swift
//  BCPChallenge
//
//  Created by Raul on 10/11/21.
//

import Foundation
import Alamofire
import UIKit
class BCPNetworkLogger: EventMonitor {
    let queue = DispatchQueue(label: "com.bcp.app.networklogger")
    func requestDidFinish(_ request: Request) {
        print(request.description)
    }
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>){
        guard let data = response.data else {
            return
        }
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
            print(json)
        }
    }
}
