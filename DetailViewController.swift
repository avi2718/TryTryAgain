//
//  DetailViewController.swift
//  Productivize
//
//  Created by Natalie on 5/31/17.
//  Copyright © 2017 Bhairavi Chandersekhar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var taskLengthTextField: UITextField!
    @IBOutlet var minChunkTextField: UITextField!
    @IBOutlet var completionSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
