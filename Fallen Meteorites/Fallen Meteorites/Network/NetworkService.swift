//
//  NetworkService.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 27.07.2021.
//

import Network
import RxSwift

public final class NetworkService {

    public static let shared: NetworkService = NetworkService(monitor: NWPathMonitor())

    private let monitor: NWPathMonitor

    public var isConnected = false

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

    public func stop() {
        monitor.cancel()
    }
}
