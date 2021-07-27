//
//  MeteoritesListViewController.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 21.07.2021.
//

import UIKit
import CoreData

class MeteoritesListViewController: UITableViewController {

    private var viewModel: MeteoritesListViewModel
    private var selectedMeteorite: Meteorite?

    private lazy var context: NSManagedObjectContext? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }

        return appDelegate.persistentContainer.viewContext
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataIfNeeded()
    }

    required init?(coder: NSCoder) {
        viewModel = MeteoritesListViewModel()
        super.init(coder: coder)
        viewModel.delegate = self
    }

    private func loadDataIfNeeded() {
        // -MR- Comment: podminky
        viewModel.loadMeteorites()
//        viewModel.setUpMeteorites()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let identifier = segue.identifier,
            let meteorite = selectedMeteorite
        else { return }

        if
            identifier == Constants.segueIdentifiers.goToMap.rawValue,
            let mapViewController = segue.destination as? MapViewController
        {
            mapViewController.meteorite = meteorite
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.meteorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "MeteoritesListIemCell")
        return viewModel.setUpCell(cell: cell, for: indexPath.row)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMeteorite = viewModel.meteorites[safe: indexPath.row]
        performSegue(withIdentifier: "goToMap", sender: self)
    }

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
}

extension MeteoritesListViewController: MeteoritesListViewModelDelegate {
    func setUpData(completition: (([Meteorite]) -> Void)) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: MeteoriteDbKeys.meteoriteDb.rawValue)

        var meteoritesDb = [MeteoriteDb]()
        var meteorites: [Meteorite]

        do {
            meteoritesDb = try context?.fetch(fetchRequest) as? [MeteoriteDb] ?? []
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

            completition(meteorites)

        } catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func saveData(_ meteorites: [Meteorite]) {
        guard let safeContext = context else { return }

        emptyDb()
        meteorites.enumerated().forEach { index, meteorite in
            // -MR- Comment: mazani db
            let meteoriteEntity = MeteoriteDb(context: safeContext)
            meteoriteEntity.id = index.description
            meteoriteEntity.name = meteorite.name
            meteoriteEntity.size = Double(meteorite.size.value)
            meteoriteEntity.latitude = meteorite.location.latitude
            meteoriteEntity.longitude = meteorite.location.longitude

            do {
                try context?.save()
            } catch let error as NSError {
                debugPrint("Could not save meteorites into database: \(error), \(error.userInfo)")
            }
        }
    }

    func refreshData() {
        tableView.reloadData()
    }
}
