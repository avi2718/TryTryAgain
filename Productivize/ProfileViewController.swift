//
//  ProfileViewController.swift
//  Productivize
//
//  Created by Bhairavi Chandersekhar on 5/23/17.
//  Copyright © 2017 Bhairavi Chandersekhar. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var breakFreqField: UITextField!
    @IBOutlet var breakLengthField: UITextField!
    @IBOutlet var breakActField: UITextField!
    
    var breakFreq: TimeInterval = 25.0
    var breakLength: TimeInterval = 25.0
    var breakAct: String = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInputViews()

        // Do any additional setup after loading the view.
    }
    
    func setInputViews() {
        let freqPicker: UIDatePicker = UIDatePicker()
        freqPicker.datePickerMode = UIDatePickerMode.countDownTimer
        breakFreqField.inputView = freqPicker
        
        let lengthPicker: UIDatePicker = UIDatePicker()
        lengthPicker.datePickerMode = UIDatePickerMode.countDownTimer
        breakFreqField.inputView = freqPicker
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
