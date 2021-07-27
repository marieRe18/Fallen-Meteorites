//
//  DatabaseService.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 27.07.2021.
//

import CoreData
import UIKit

public final class DatabaseService {

    private lazy var context: NSManagedObjectContext? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }

        return appDelegate.persistentContainer.viewContext
    }()

    private func emptyDb() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: MeteoriteDbKeys.meteoriteDb.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context?.execute(deleteRequest)
        } catch let error as NSError {
            // -MR- Comment: handle?
            debugPrint("Could not delete objects in database. \(error), \(error.userInfo)")
        }
    }
    
    func saveMeteorites(_ meteorites: [Meteorite], completition: @escaping (() -> Void)) {
        guard let safeContext = context else { return }

        DispatchQueue.main.async { [weak self] in
            self?.emptyDb()
            meteorites.enumerated().forEach { index, meteorite in
                // -MR- Comment: mazani db
                let meteoriteEntity = MeteoriteDb(context: safeContext)
                meteoriteEntity.id = index.description
                meteoriteEntity.name = meteorite.name
                meteoriteEntity.size = Double(meteorite.size.value)
                meteoriteEntity.latitude = meteorite.location.latitude
                meteoriteEntity.longitude = meteorite.location.longitude

                do {
                    try self?.context?.save()
                } catch let error as NSError {
                    debugPrint("Could not save meteorites into database: \(error), \(error.userInfo)")
                }
            }
            completition()
        }
    }

    func loadMeteorites(completition: @escaping (([Meteorite]) -> Void)) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: MeteoriteDbKeys.meteoriteDb.rawValue)

        var meteoritesDb = [MeteoriteDb]()
        var meteorites = [Meteorite]()

        DispatchQueue.main.async { [weak self] in
            do {
                meteoritesDb = try self?.context?.fetch(fetchRequest) as? [MeteoriteDb] ?? []
                meteorites = meteoritesDb.compactMap {
                    let sizeValue = $0.value(forKey: MeteoriteDbKeys.size.rawValue) as? Int ?? 0
                    let latitude = $0.value(forKey: MeteoriteDbKeys.latitude.rawValue) as? Double ?? 0.0
                    let longitude = $0.value(forKey: MeteoriteDbKeys.longitude.rawValue) as? Double ?? 0.0

                    let name = $0.value(forKey: MeteoriteDbKeys.name.rawValue) as? String ?? ""
                    let size = Size(value: sizeValue)
                    let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

                    return Meteorite(
                        name: name,
                        size: size,
                        location: location)
                }

            } catch let error as NSError {
                debugPrint("Could not fetch. \(error), \(error.userInfo)")
            }
            completition(meteorites)
        }
    }
}
