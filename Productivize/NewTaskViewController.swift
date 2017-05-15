//
//  NewTaskViewController.swift
//  Productivize
//
//  Created by Bhairavi Chandersekhar on 5/14/17.
//  Copyright © 2017 Bhairavi Chandersekhar. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet var nameField: UITextField!
    @IBOutlet var dateField: UITextField!
    @IBOutlet var categoryField: UITextField!
    @IBOutlet var lengthField: UITextField!
    @IBOutlet var minChunkField: UITextField!
    @IBOutlet var completionSlider: UISlider!
    @IBOutlet var remainderField: UILabel!
    
    var categories = ["Work", "Wellness"]
    
    var name: String = " "
    var dueDate = Date()
    var category: String = " "
    var taskLength: TimeInterval = 0.0
    var minChunk: TimeInterval = 0.0
    
    @IBAction func dismissCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissAdd(_ sender: Any) {
        let _ = Task(name: nameField.text!, dueDate: dueDate, category: category, length: taskLength, minChunk: minChunk)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInputViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setInputViews() {
        let datePicker  : UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        dateField.inputView = datePicker
        
        let catPicker = UIPickerView()
        categoryField.inputView = catPicker
        catPicker.dataSource = self
        catPicker.delegate = self
        
        let lengthPicker = UIDatePicker()
        lengthPicker.datePickerMode = UIDatePickerMode.countDownTimer
        lengthField.inputView = lengthPicker
        
        let minChunkPicker = UIDatePicker()
        minChunkPicker.datePickerMode = UIDatePickerMode.countDownTimer
        minChunkField.inputView = minChunkPicker
        
        completionSlider.value = 0.0
    }
    
    @IBAction func dateTapped(_ sender: UITextField) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let myDatePicker = sender.inputView as? UIDatePicker
        dueDate = myDatePicker!.date
        dateField.text = dateFormatter.string(from: dueDate)
    }
    
    
    @IBAction func catTapped(_ sender: UITextField) {
        let myCatPicker = sender.inputView as? UIPickerView
        category = categories[(myCatPicker?.selectedRow(inComponent: 0))!]
        categoryField.text = category
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
        lengthField.text = stringFromTimeInterval(interval: myTimePicker.countDownDuration)
        taskLength = myTimePicker.countDownDuration
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        let ti = NSInteger(interval)
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        //return NSString(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
        return "\(hours) hours \(minutes) minutes"
    }
    
    @IBAction func chunkTapped(_ sender: UITextField) {
        let myTimePicker = sender.inputView as! UIDatePicker
        minChunk = myTimePicker.countDownDuration
        minChunkField.text = stringFromTimeInterval(interval: minChunk)
    }
    @IBAction func sliderSlid(_ sender: UISlider) {
        var timeLeftString = "Time Left: "
        timeLeftString += stringFromTimeInterval(interval: (taskLength * Double(1-sender.value)))
        remainderField.text = timeLeftString
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
