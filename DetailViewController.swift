//
//  DetailViewController.swift
//  Productivize
//
//  Created by Natalie on 5/31/17.
//  Copyright © 2017 Bhairavi Chandersekhar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var taskLengthTextField: UITextField!
    @IBOutlet var minChunkTextField: UITextField!
    @IBOutlet var completionSlider: UISlider!
    
    var categories = ["Work", "Wellness"]

    var name: String = " "
    var dueDate = Date()
    var category: String = " "
    var taskLength: TimeInterval = 0.0
    var minChunk: TimeInterval = 0.0
    var curTask = Task()
    var index : Int = 0
    
    @IBAction func dismissCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func dismissDone(_ sender: Any) {
        curTask = Task(name: nameTextField.text!, dueDate: dueDate, category: category, length: taskLength)
        Task.allTasks[index] = curTask
        dismiss(animated: true, completion: nil)
    }
    
    func checkCurrent() {
        var i = 0
        for t in Task.allTasks {
            if t.current {
                curTask = t
                index = i
            }
            i += 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkCurrent()
        setDefault()
        setInputViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDefault() {
        if curTask != nil {
            nameTextField.placeholder = curTask.name
            dateTextField.placeholder = curTask.dueDate.description
            categoryTextField.placeholder = curTask.category
            taskLengthTextField.placeholder = curTask.length.description
        }
    }
    
    func setInputViews() {
        let datePicker  : UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        dateTextField.inputView = datePicker
        
        let catPicker = UIPickerView()
        categoryTextField.inputView = catPicker
        catPicker.dataSource = self
        catPicker.delegate = self
        let lengthPicker = UIDatePicker()
        lengthPicker.datePickerMode = UIDatePickerMode.countDownTimer
        taskLengthTextField.inputView = lengthPicker
    }
    
    @IBAction func dateTapped(_ sender: UITextField) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let myDatePicker = sender.inputView as? UIDatePicker
        dueDate = myDatePicker!.date
        dateTextField.text = dateFormatter.string(from: dueDate)
    }
    
    
    @IBAction func catTapped(_ sender: UITextField) {
        let myCatPicker = sender.inputView as? UIPickerView
        category = categories[(myCatPicker?.selectedRow(inComponent: 0))!]
        categoryTextField.text = category
    }
    
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    @IBAction func lengthTapped(_ sender: UITextField) {
        let myTimePicker = sender.inputView as! UIDatePicker
        taskLengthTextField.text = stringFromTimeInterval(interval: myTimePicker.countDownDuration)
        taskLength = myTimePicker.countDownDuration
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        let ti = NSInteger(interval)
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        //return NSString(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
        return "\(hours) hours \(minutes) minutes"
    }
    

}
