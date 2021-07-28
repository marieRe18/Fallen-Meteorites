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
    public static let since2011 = "since 2011"

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
        public static let darkBlue = #colorLiteral(red: 0.227437973, green: 0.247009933, blue: 0.2783507705, alpha: 1)
        public static let standardWhite = #colorLiteral(red: 0.9332844615, green: 0.9333672523, blue: 0.9332153201, alpha: 1)
        public static let standardGray = #colorLiteral(red: 0.4746527672, green: 0.4822291136, blue: 0.5684540868, alpha: 1)

    }
}
