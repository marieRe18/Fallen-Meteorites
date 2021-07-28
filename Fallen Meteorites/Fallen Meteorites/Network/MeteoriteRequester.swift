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

    private let networkService = NetworkService.shared

    func getMeteorites(sinceYear: Int = 2011) -> Single<[Meteorite]> {
        let year = sinceYear - 1
        let yearFilterParameter = ["$where": "year>'\(year)-12-31T23:59:59.999'"]

// NOTE: -MR- Requested on main thread because it brings essential data
        return Single<[Meteorite]>.create(subscribe: { [weak self] single -> Disposable in
            guard self?.networkService.isConnected ?? false else {
                single(.failure(MeteoriteRequesterError.noInternetConnection))
                return Disposables.create()
            }
        AF.request(
            Constants.ApiUrls.nasaLandedMeteorites,
            parameters: yearFilterParameter,
            encoder: URLEncodedFormParameterEncoder(destination: .queryString),
            headers: [Constants.appTokenValue: Constants.appToken]
        )
        .validate().responseJSON(queue: .main) { response in
            switch response.result {
            case .success:
                print(response)
                do {
                    guard let data = response.data else {
                        DispatchQueue.main.async {
                            debugPrint(MeteoriteRequesterError.parsingError)
                            single(.failure(MeteoriteRequesterError.unexpectedError))
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
                        debugPrint(MeteoriteRequesterError.parsingError)
                        single(.failure(MeteoriteRequesterError.unexpectedError))
                    }
                }
            case let .failure(error):
                debugPrint(error)
                single(.failure(error))
            }
        }
            return Disposables.create()
        })
    }
}

enum MeteoriteRequesterError: LocalizedError {
    case parsingError
    case noInternetConnection
    case unexpectedError

    var errorDescription: String? {
        switch self {
        case .parsingError:
            return Constants.Errors.parsingError
        case .noInternetConnection:
            return Constants.Errors.noInternetConnectionError
        case .unexpectedError:
            return Constants.Errors.unexpectedError
        }
    }
}
