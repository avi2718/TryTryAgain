//
//  DraggableView.swift
//  Productivize
//
//  Created by Bhairavi Chandersekhar on 5/15/17.
//  Copyright © 2017 Bhairavi Chandersekhar. All rights reserved.
//

import UIKit

class TaskView: UIView {
    var panGesture = UIPanGestureRecognizer()
    var task: Task
    
    init (frame: CGRect, task: Task) {
        self.task = task
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.task = Task()
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setup () {
        backgroundColor = UIColor.cyan
        layer.cornerRadius = frame.size.width/2
        layer.masksToBounds = true
        panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(viewDidDragged))
        addGestureRecognizer(panGesture)
    }
    
    func viewDidDragged() {
        let height = self.superview!.frame.height
        let width = self.superview!.frame.width
        
        let newPoint = panGesture.location(in: self.superview)
        let newFrame = CGRect(x: newPoint.x - frame.width/2, y: newPoint.y - frame.height/2, width: frame.width, height: frame.height)
        frame = newFrame
        
        
    }
    
}
