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
    var taskNumber = 0
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
        resetButton.isEnabled = false
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
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell?
        if (cell != nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        }
        
        let item = taskList![indexPath.row]
        cell?.textLabel?.text = item.name
        cell?.detailTextLabel?.text = timeString(time: item.length)
        return cell!
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
            taskCompletedAlert()
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
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["taskOver"])
            resumeTapped = true
            pauseButton.setTitle("Resume",for: .normal)
        } else {
            runTimer()
            sendNotification(time: TimeInterval(Double(seconds)))
            resumeTapped = false
            pauseButton.setTitle("Pause",for: .normal)
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["taskOver"])
        if let a = taskList?[0].length {
            seconds = Int(a)
        }
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
    
    func taskCompletedAlert() {
        let alert = UIAlertController(
            title: "Time's up!",
            message: "It's time to start working on your next task.",
            preferredStyle: .alert)
        let updatePreviousAction = UIAlertAction(title: "Update Previous", style: .default, handler: {(action:UIAlertAction!) in self.updateScreen()})
        alert.addAction(updatePreviousAction)
        let nextTaskAction = UIAlertAction(title: "Next Task", style: .default, handler: {(action:UIAlertAction!) in self.nextTask()})
        alert.addAction(nextTaskAction)
        present(alert, animated: true, completion: nil)
    }
    
    func listCompletedAlert() {
        let alert = UIAlertController(
            title: "You're done!",
            message: "You've finished working for the length of time you wanted to.",
            preferredStyle: .alert)
        let updatePreviousAction = UIAlertAction(title: "Update Previous", style: .default, handler: {(action:UIAlertAction!) in self.updateScreen()})
        alert.addAction(updatePreviousAction)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func updateScreen() {
        print("update screen should now pop up")
    }
    
    func nextTask() {
        taskNumber += 1
        if taskNumber < (taskList?.count)! {
            seconds = Int((taskList?[taskNumber].length)!)
            runTimer()
        } else {
            listCompletedAlert()
        }
    }

}
