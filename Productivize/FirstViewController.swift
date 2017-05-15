//
//  FirstViewController.swift
//  Productivize
//
//  Created by Bhairavi Chandersekhar on 5/14/17.
//  Copyright © 2017 Bhairavi Chandersekhar. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet var button: UIButton!

    @IBAction func buttonTapped(_ sender: Any) {
        let rect = CGRect(x: 150, y: 150, width: 10, height: 10)
        let newView = DraggableView(frame: rect)
        self.view.addSubview(newView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

