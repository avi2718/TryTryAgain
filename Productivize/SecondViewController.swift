//
//  SecondViewController.swift
//  Productivize
//
//  Created by Bhairavi Chandersekhar on 5/14/17.
//  Copyright © 2017 Bhairavi Chandersekhar. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet var myView: UIView!
    var panGesture = UIPanGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(viewDidDragged))
        myView.addGestureRecognizer(panGesture)
        
        myView.layer.cornerRadius = self.myView.frame.size.width/2
        myView.layer.masksToBounds = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func viewDidDragged() {
        let newPoint = panGesture.location(in: self.view)
        let newFrame = CGRect(x: newPoint.x - myView.frame.width/2, y: newPoint.y - myView.frame.height/2, width: myView.frame.width, height: myView.frame.height)
        myView.frame = newFrame
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

