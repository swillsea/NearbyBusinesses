//
//  MainViewController.swift
//  PizzaFinder
//
//  Created by Sam on 4/6/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var directionsButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    let locationManager = CLLocationManager()
    var location = CLLocation()
    var searchDistance = Double()
    var bizArray = []
    var searchText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchText = "Pizza"

        self.directionsButton.layer.cornerRadius = 5
        self.directionsButton.layer.masksToBounds = true

        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.first!
        
        if location.horizontalAccuracy < 1000 && location.verticalAccuracy < 1000 {
            self.findNearbyBiznizes(location)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchText = self.searchBar.text!
        self.findNearbyBiznizes(location)
        self.searchBar.resignFirstResponder()
    }
    
//    @IBAction func onDistanceSliderUpdated(sender: AnyObject) {
//        self.searchDistance = Double(distanceSlider.value)
//        self.findNearbyBiznizes(location)
//    }
    
    func findNearbyBiznizes (location: CLLocation) {
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = self.searchText
        request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(self.searchDistance,self.searchDistance))
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response, error) in
            self.bizArray = (response?.mapItems)!
            let mapItem = response?.mapItems.first
            self.getDirectionsToBizniz(mapItem!)
            self.tableView.reloadData()
        }
        
    }
    
    func getDirectionsToBizniz (mapItem: MKMapItem) {
        
        let request = MKDirectionsRequest()
        request.source = MKMapItem.mapItemForCurrentLocation()
        request.destination = mapItem
        let direction = MKDirections(request: request)
        
        direction.calculateDirectionsWithCompletionHandler { (response, error) in
            let route = response?.routes.first
            
            for step in route!.steps {
                self.textView.text = self.textView.text + "\(step.instructions)\n"
            }
        }
        
    }
    
    @IBAction func onTransportModSelected(sender: UISegmentedControl) {
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bizArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel!.text = bizArray[indexPath.row].name
        
        let distanceInMeters = location.distanceFromLocation((bizArray[indexPath.row] as! MKMapItem).placemark.location!)
        let distanceInMiles = distanceInMeters * 0.000621371
        let distanceInFeet = distanceInMiles * 5280
        
        if distanceInFeet > 1000 {
            cell.detailTextLabel!.text = String(format: "%.2f miles away", distanceInMiles)
        } else if distanceInFeet < 50 {
            cell.detailTextLabel!.text = "You're basically there"
        } else {
            cell.detailTextLabel!.text = String(format: "%1.0f feet away", distanceInFeet)
        }
        
        return cell
    }
    
    @IBAction func onDirectionsButtonPressed(sender: UIButton) {
    
    }
}
