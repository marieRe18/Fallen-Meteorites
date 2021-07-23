//
//  MeteoriteRequester.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 23.07.2021.
//

import Foundation
import Alamofire
import RxSwift

final class MeteoriteRequester {
    func getMeteorites(sinceYear: Int = 2011) -> Single<[Meteorite]> {
        let year = sinceYear - 1
        let yearFilterParameter = ["$where": "year>'\(year)-12-31T23:59:59.999'"]

        return Single<[Meteorite]>.create(subscribe: { single -> Disposable in
        AF.request(
            Constants.ApiUrls.nasaLandedMeteorites,
            parameters: yearFilterParameter,
            encoder: URLEncodedFormParameterEncoder(destination: .queryString),
            headers: [Constants.appTokenValue: Constants.appToken]
        )
        .validate().responseJSON(queue: .global(qos: .background)) { response in
// -MR- Comment: generalizace
            switch response.result {
            case .success:
                print(response)
                do {
                    guard let data = response.data else {
                        DispatchQueue.main.async {
                            single(.failure(MeteoriteRequesterError.parsingError))
                        }
                        return
                    }
                    let decoder = JSONDecoder()
                    let decoded = try decoder.decode([Meteorite].self, from: data)
                    DispatchQueue.main.async {
                        single(.success(decoded))
                    }
                } catch {
                    DispatchQueue.main.async {
                        single(.failure(MeteoriteRequesterError.parsingError))
                    }
                }
            case let .failure(error):
                debugPrint(error)
            }
        }
            return Disposables.create()
        })
    }
}

enum MeteoriteRequesterError: LocalizedError {
    case parsingError

    var errorDescription: String? {
        switch self {
        case .parsingError:
            return Constants.Errors.parsingError
        }
    }
}
