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

    var location: CLLocation?

    lazy private var dataSource: NXTDataSource? = {
        guard let dataSource = NXTDataSource(objects: nil, from: self) else { return nil }
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

        location = getCurrentLocation()
        guard let currentLocation = location else { return }
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
            guard let indexPath = tableView.indexPathForSelectedRow,
                let navigationController = segue.destination as? UINavigationController,
                    let controller = navigationController.topViewController as? DetailViewController else {
                return
            }
            guard let business = dataSource?.objects[indexPath.row] as? YLPBusiness else { return }
            controller.detailItem = business
            controller.setBusiness(with: business)
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }

    // MARK: - Helper methods
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

    func getBusinesses(near location: CLLocation, offset: UInt = 0, onComplete: @escaping (Result< YLPSearchQuery, Error>) -> Void) {
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
            dataSource.setObjects(businesses)
            strongSelf.tableView.reloadData()
        })
    }
}
