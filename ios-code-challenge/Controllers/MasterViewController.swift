//
//  MasterViewControllerS.swift
//  ios-code-challenge
//
//  Created by Joe Rocca on 5/31/19.
//  Copyright © 2019 Dustin Lange. All rights reserved.
//

import UIKit
import CoreLocation

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController?


    lazy private var dataSource: NXTDataSource? = {
        guard let dataSource = NXTDataSource(objects: nil) else { return nil }
        dataSource.tableViewDidReceiveData = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadData()
        }
        return dataSource
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.delegate = dataSource

        let currentLocation = getCurrentLocation()
        getBusinesses(near: currentLocation) { result in
            switch result {
            case .success(let query):
                self.makeNetworkCall(with: query)
            case .failure(let error):
                DispatchQueue.main.async {
                    Alert.showSimpleAlert(with: "An error occured.", message: error.localizedDescription, viewController: self)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController?.isCollapsed ?? false
        super.viewDidAppear(animated)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
//            guard let indexPath = tableView.indexPathForSelectedRow,
//                let controller = segue.destination as? DetailViewController else {
//                return
//            }
//            let object = objects[indexPath.row]
//            controller.setDetailItem(newDetailItem: object)
//            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
//            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }

    func getCurrentLocation() -> CLLocation {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        guard let location = locationManager.location else {
            fatalError("Could not get current location.")
        }
        return location
    }

    func getBusinesses(near location: CLLocation, onComplete: @escaping (Result< YLPSearchQuery, Error>) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if error == nil {
                guard let placemark = placemarks?.first,
                    let address = placemark.name,
                    let city = placemark.locality,
                    let zipCode = placemark.postalCode else { return }
                let queryLocation = address + " " + city + " " + zipCode
                let query = YLPSearchQuery(location: queryLocation)
                onComplete(.success(query))
            } else {
                guard let error = error else {
                    fatalError("Geocoder fatal error.")
                }
                onComplete(.failure(error))
            }
        }
    }

    // MARK: - Network call
    func makeNetworkCall(with query: YLPSearchQuery) {
        AFYelpAPIClient.shared().search(with: query, completionHandler: { [weak self] (searchResult, error) in
            guard let strongSelf = self,
                let dataSource = strongSelf.dataSource,
                let businesses = searchResult?.businesses else {
                    return
            }

            // Sort the businesses by distance
            let businessesByDistance = businesses.sorted(by: { $0.distance < $1.distance })
            dataSource.setObjects(businessesByDistance)
            strongSelf.tableView.reloadData()
        })
    }
}
