//
//  MasterViewControllerS.swift
//  ios-code-challenge
//
//  Created by Joe Rocca on 5/31/19.
//  Copyright © 2019 Dustin Lange. All rights reserved.
//

import UIKit

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
        
        let query = YLPSearchQuery(location: "5550 West Executive Dr. Tampa, FL 33609")
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

}
