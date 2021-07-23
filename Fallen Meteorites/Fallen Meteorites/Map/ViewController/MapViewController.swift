//
//  MapViewController.swift
//  Fallen Meteorites
//
//  Created by Marie Re on 23.07.2021.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var mapView: MKMapView!

    private var viewModel: MapViewModel

    var meteorite: Meteorite? {
        get { viewModel.meteorite }
        set { viewModel.meteorite = newValue }
    }

    required init?(coder: NSCoder) {
        viewModel = MapViewModel()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        setUpLayout()
        super.viewDidLoad()
    }

    private func setUpLayout() {
        // -MR- Comment: dodelat - lokace
        location.text = meteorite?.name
    }
}
