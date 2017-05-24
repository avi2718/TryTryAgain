//
//  ListViewController.swift
//  Productivize
//
//  Created by Bhairavi Chandersekhar on 5/24/17.
//  Copyright © 2017 Bhairavi Chandersekhar. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var taskList: [Task]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskList = Task.allTasks
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        if taskList!.count > 0 {
            return
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList!.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath as IndexPath)
        
        let item = taskList![indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }

}
