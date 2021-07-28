//
//  Constants.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 23.07.2021.
//

import UIKit

public struct Constants {
    public static let appToken = "X-App-Token"
    public static let appTokenValue = "ODqdLYKjJDAPpFUCiLnMrhyFy"

    enum SegueIdentifiers: String {
        case goToMap
    }

    public struct ApiUrls {
        public static let nasaLandedMeteorites = "https://data.nasa.gov/resource/gh4g-9sfh.json"
    }

    public struct Errors {
        public static let parsingError = "Error when parsing response data."
        public static let noInternetConnectionError = "No internet connection."
    }

    public struct Colors {
        public static let darkBlue = #colorLiteral(red: 0.06423496455, green: 0.01829280145, blue: 0.3017384112, alpha: 1)
        public static let standardBlue = #colorLiteral(red: 0.08383090049, green: 0.1207188442, blue: 0.3840562105, alpha: 1)
        public static let standardWhite = #colorLiteral(red: 0.9332844615, green: 0.9333672523, blue: 0.9332153201, alpha: 1)
        public static let standardGray = #colorLiteral(red: 0.4746527672, green: 0.4822291136, blue: 0.5684540868, alpha: 1)

    }
}
