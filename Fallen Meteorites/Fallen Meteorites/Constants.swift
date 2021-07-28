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

    enum MeteoriteImage: Int {
        case sizeOne
        case sizeTwo
        case sizeThree
        case sizeFour

        var img: UIImage? {
            get {
                switch self {
                case .sizeOne:
                    return Images.sizeOneImg
                case .sizeTwo:
                    return Images.sizeTwoImg
                case .sizeThree:
                    return Images.sizeThreeImg
                case .sizeFour:
                    return Images.sizeFourImg
                }
            }
        }
    }

    fileprivate struct Images {
        static let sizeOneImg = UIImage(named: "meteorite")?.imageMagnyfied(by: 0.3)
        static let sizeTwoImg = UIImage(named: "meteorite")?.imageMagnyfied(by: 0.5)
        static let sizeThreeImg = UIImage(named: "meteorite")?.imageMagnyfied(by: 0.7)
        static let sizeFourImg = UIImage(named: "meteorite")
    }

    struct ApiUrls {
        public static let nasaLandedMeteorites = "https://data.nasa.gov/resource/gh4g-9sfh.json"
    }

    struct Errors {
        public static let parsingError = "Error when parsing response data."
        public static let noInternetConnectionError = "No internet connection."
        public static let unexpectedError = "Unexpected error occured while fetching data from the internet."
    }

    struct Colors {
        public static let darkBlue = #colorLiteral(red: 0.5459182858, green: 0.2666829228, blue: 0.4077201486, alpha: 1)
        public static let standardBlue = #colorLiteral(red: 0.333951056, green: 0.2232597172, blue: 0.3958826065, alpha: 1)
        public static let standardWhite = #colorLiteral(red: 0.9332844615, green: 0.9333672523, blue: 0.9332153201, alpha: 1)
        public static let standardGray = #colorLiteral(red: 1, green: 0.3968307376, blue: 0.3963495791, alpha: 1)

    }
}
