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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    required init?(coder: NSCoder) {
        viewModel = MeteoritesListViewModel()
        super.init(coder: coder)
        viewModel.delegate = self
        loadDataIfNeeded()
    }

    private func loadDataIfNeeded() {
        // -MR- Comment: podminky
        viewModel.loadMeteorites()
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
}

extension MeteoritesListViewController: MeteoritesListViewModelDelegate {
    func saveData(_ meteorites: [Meteorite], completition: (() -> Void)) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let context = appDelegate.persistentContainer.viewContext

        meteorites.forEach { meteorite in
            guard
                let entity = NSEntityDescription.entity(forEntityName: "Meteorite", in: context)
            else { return }

            let latitude = Double(meteorite.location.latitude.description)
            let longitude = Double(meteorite.location.longitude.description)

            let meteoriteEntity = NSManagedObject(entity: entity, insertInto: context)

            meteoriteEntity.setValue(meteorite.name, forKey: MeteoriteDbKeys.name.rawValue)
            meteoriteEntity.setValue(meteorite.size.value, forKey: MeteoriteDbKeys.size.rawValue)
            meteoriteEntity.setValue(latitude, forKey: MeteoriteDbKeys.lat.rawValue)
            meteoriteEntity.setValue(longitude, forKey: MeteoriteDbKeys.long.rawValue)
        }

        do {
            try context.save()
        } catch let error as NSError {
            debugPrint("Could not save meteorites into database: \(error), \(error.userInfo)")
        }

        completition()
    }

    func refreshData() {
        tableView.reloadData()
    }
}
