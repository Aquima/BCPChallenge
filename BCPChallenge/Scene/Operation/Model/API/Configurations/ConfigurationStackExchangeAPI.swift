//
//  ConfigurationHomeMeliAPI.swift
//  BCPChallenge
//
//  Created by Raul on 17/11/21.
//
import Foundation
extension Configuration {
    static var userAccountAPI: [String: Any] {
        let path = Bundle.main.path(forResource: "HomeConfigurations", ofType: "plist")
        let url = URL.init(fileURLWithPath: path!)
        do {
            guard let data = try? Foundation.Data(contentsOf: url),
                  let result = try PropertyListSerialization.propertyList(
                    from: data,
                    options: [],
                    format: nil
                  ) as? [String: Any] else {
                return [:]
            }
            return result
        } catch {
            return [:]
        }
    }
    // MARK: URLBASE
    private func getURLBaseHomeMeliAPI() -> String {
        if let scheme: String = Configuration.configurationValueForKeyAndSubKey(
            key: "Api",
            subKey: "scheme",
            baseConfigurationDictionary: Configuration.userAccountAPI) as? String {
            self.scheme = scheme
        }
        if let basePath: String = Configuration.configurationValueForKeyAndSubKey(
            key: "Api",
            subKey: "host",
            baseConfigurationDictionary: Configuration.userAccountAPI) as? String {
            self.basePath = basePath
        }
        return self.scheme + self.basePath
    }
    // MARK: Base Urls
    private static var baseStackExchange: String? {
        let configuration = Configuration()
        let urlBase = configuration.getURLBaseHomeMeliAPI()

        let basePathAuth = Configuration.configurationValueForKeyAndSubKey(
            key: "Api",
            subKey: "baseStackExchange",
            baseConfigurationDictionary: Configuration.userAccountAPI
        ) as? String

        return urlBase + basePathAuth!
    }

    // MARK: Main Urls
    static var urlStackExchange: String {
        guard let url = baseStackExchange else {
            fatalError("the url should exist")
        }
        return url
    }
}
