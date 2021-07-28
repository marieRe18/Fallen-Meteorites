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
        public static let darkBlue = #colorLiteral(red: 0.5459182858, green: 0.2666829228, blue: 0.4077201486, alpha: 1)
        public static let standardBlue = #colorLiteral(red: 0.333951056, green: 0.2232597172, blue: 0.3958826065, alpha: 1)
        public static let standardWhite = #colorLiteral(red: 0.9332844615, green: 0.9333672523, blue: 0.9332153201, alpha: 1)
        public static let standardGray = #colorLiteral(red: 1, green: 0.3968307376, blue: 0.3963495791, alpha: 1)

    }

    enum MeteoriteImage: Int {
        case sizeOne
        case sizeTwo
        case sizeThree
        case sizeFour

        private static let sizeOneImg = UIImage(named: "meteorite")?.imageMagnyfied(by: 1)
        private static let sizeTwoImg = UIImage(named: "meteorite")?.imageMagnyfied(by: 1.2)
        private static let sizeThreeImg = UIImage(named: "meteorite")?.imageMagnyfied(by: 1.4)
        private static let sizeFourImg = UIImage(named: "meteorite")?.imageMagnyfied(by: 1.6)

        var img: UIImage? {
            get {
                switch self {
                case .sizeOne:
                    return MeteoriteImage.sizeOneImg
                case .sizeTwo:
                    return MeteoriteImage.sizeTwoImg
                case .sizeThree:
                    return MeteoriteImage.sizeThreeImg
                case .sizeFour:
                    return MeteoriteImage.sizeFourImg
                }
            }
        }

    }
}
