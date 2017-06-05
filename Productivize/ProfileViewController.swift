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
    @IBOutlet var breakActField: UITextView!
    
    var profile: Profile?
    var breakFreq: TimeInterval = 1500
    var breakLength: TimeInterval = 300
    var breakAct: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        let freqPicker: UIDatePicker = UIDatePicker()
        freqPicker.datePickerMode = UIDatePickerMode.countDownTimer
        breakFreqField.inputView = freqPicker
        
        let lengthPicker: UIDatePicker = UIDatePicker()
        lengthPicker.datePickerMode = UIDatePickerMode.countDownTimer
        breakFreqField.inputView = freqPicker
        
        breakFreq = profile!.breakFreq
        breakLength = profile!.breakLength
        if let a = profile!.breakAct {
            breakAct = a
        } else {
            breakAct = "Click to Edit"
        }
        
        breakActField.text = breakAct
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
