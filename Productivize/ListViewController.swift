//
//  ListViewController.swift
//  Productivize
//
//  Created by Bhairavi Chandersekhar on 5/24/17.
//  Copyright © 2017 Bhairavi Chandersekhar. All rights reserved.
//

import UIKit
import UserNotifications

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var taskList: [Task]?
    
    var seconds = 5
    var timer = Timer()
    var isTimerRunning = false
    
    var resumeTapped = false
    
    
    
    //MARK: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotifications()
        sendNotification(time: TimeInterval(5))
        
        taskList = Task.allTasks
        if let a = taskList?[0].length {
            seconds = Int(a)
        }
        sendNotification(time: TimeInterval(Double(seconds)))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        pauseButton.isEnabled = false
        if taskList!.count > 0 {
            return
        }
    }
    
    

    //MARK: TABLE VIEW
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
    
    
    
    //MARK: TIMER
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ListViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        pauseButton.isEnabled = true
    }
    
    func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            makeAlert()
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
            startButton.isEnabled = false
            resetButton.isEnabled = true
            pauseButton.isEnabled = true
            pauseButton.setTitle("Pause",for: .normal)  }
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            resumeTapped = true
            pauseButton.setTitle("Resume",for: .normal)
        } else {
            runTimer()
            resumeTapped = false
            pauseButton.setTitle("Pause",for: .normal)
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        seconds = 60
        timerLabel.text = timeString(time: TimeInterval(seconds))
        
        isTimerRunning = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true
        resetButton.isEnabled = false
    }
    
    
    
    //MARK: NOTIFICATIONS
    func sendNotification(time: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Time to move on!"
        content.body = "It's time to start working on your next task."
        content.categoryIdentifier = "TASK_OVER"
        content.sound = UNNotificationSound.default()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        let request = UNNotificationRequest(identifier: "taskOver", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func setupNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in })
        let updateTask = UNNotificationAction(identifier: "UPDATE_PREVIOUS", title: "Update Previous Task", options: .foreground)
        let nextTask = UNNotificationAction(identifier: "NEXT_TASK", title: "Next Task", options: UNNotificationActionOptions(rawValue: 0))
        let taskCompleted = UNNotificationCategory(identifier: "TASK_OVER", actions: [updateTask, nextTask], intentIdentifiers: [], options: UNNotificationCategoryOptions(rawValue: 0))
        UNUserNotificationCenter.current().setNotificationCategories([taskCompleted])
    }
    
    func makeAlert() {
        let alert = UIAlertController(
            title: "Time's up!",
            message: "It's time to start working on your next task.",
            preferredStyle: .alert)
        let updatePreviousAction = UIAlertAction(title: "Update Previous", style: .default, handler: nil)
        alert.addAction(updatePreviousAction)
        let nextTaskAction = UIAlertAction(title: "Next Task", style: .default, handler: nil)
        alert.addAction(nextTaskAction)
        present(alert, animated: true, completion: nil)
    }

}
