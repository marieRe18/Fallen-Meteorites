//
//  MeteoriteRequester.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 23.07.2021.
//

import Foundation
import Alamofire

public struct ApiUrls {
    public static let nasaLandedMeteorites = "https://data.nasa.gov/resource/gh4g-9sfh.json"
}

public struct Constants {
    public static let appToken = "X-App-Token"
    // -MR- Comment: token zabezpecit nekam
    public static let appTokenValue = "ODqdLYKjJDAPpFUCiLnMrhyFy"
}

final class MeteoriteRequester {
    func getMeteorites(sinceYear: Int = 2011) {
        // -MR- Comment: nepresne, dodelat timestamp creation
        let yearFilterParameter = ["$where": "year>'2017-01-01T00:00:00.000'"]

        AF.request(
            ApiUrls.nasaLandedMeteorites,
            parameters: yearFilterParameter,
            encoder: URLEncodedFormParameterEncoder(destination: .queryString),
            headers: [Constants.appTokenValue: Constants.appToken]
        )
        .validate().responseJSON { response in
            print(response)
        }



         // -MR- Comment: remove
//        let urlWithYearFilter = URL(string: urlStringWithYearFilter.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
//        var request = URLRequest(url: urlWithYearFilter!)
//        request.setValue("ODqdLYKjJDAPpFUCiLnMrhyFy", forHTTPHeaderField: "X-App-Token")
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard
//                let data = data,
//                error == nil
//            else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//
//            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//            if let responseJSON = responseJSON as? [String: Any] {
//                print(responseJSON)
//            }
//        }
//
//        task.resume()
    }
}
