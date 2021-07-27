//
//  NetworkService.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 27.07.2021.
//

import Network
import RxSwift

public final class NetworkService {

    private let monitor: NWPathMonitor

//    public var isConnected: Single<Bool> {
//        return Single<Bool>.create(subscribe: { single -> Disposable in
//            self.monitor.pathUpdateHandler = { path in
//                single(.success(path.status == .satisfied) )
//            }
//            return Disposables.create()
//        })
    public var isConnected = false

    public static let shared: NetworkService = NetworkService(monitor: NWPathMonitor())

    private init(monitor: NWPathMonitor) {
        self.monitor = monitor
    }

    public func start() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        let queue = DispatchQueue(label: "Internet connection monitor")
        monitor.start(queue: queue)
    }
}
