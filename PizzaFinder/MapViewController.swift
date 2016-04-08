//
//  MapViewController.swift
//  PizzaFinder
//
//  Created by Sam on 4/6/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var bizArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true

    }

    

}
