//
//  BuildConfiguration.swift
//  BCPChallenge
//
//  Created by Raul on 7/09/21.
//

import UIKit

enum Environment: String {
    case debugDevelopment = "Debug"
    case release = "Release"
}

class BuildConfiguration {
    static let shared = BuildConfiguration()
    var environment: Environment

    init() {
        let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String

        environment = Environment(rawValue: currentConfiguration!)!
    }
}
