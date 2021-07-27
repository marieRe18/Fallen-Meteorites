//
//  Constants.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 23.07.2021.
//

public struct Constants {
    public static let appToken = "X-App-Token"
    public static let appTokenValue = "ODqdLYKjJDAPpFUCiLnMrhyFy"

    public struct ApiUrls {
        public static let nasaLandedMeteorites = "https://data.nasa.gov/resource/gh4g-9sfh.json"
    }

    enum segueIdentifiers: String {
        case goToMap
    }

    public struct Errors {
        public static let parsingError = "Error: when parsing response data"
    }
}
