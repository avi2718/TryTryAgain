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
    var selectedGesture = UILongPressGestureRecognizer()
    var task: Task
    var detailViewController = DetailViewController()
    
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
        if task.category == "Work" {
            backgroundColor = UIColor.red
        } else {
            backgroundColor = UIColor.blue
        }
        layer.cornerRadius = frame.size.width/2
        layer.masksToBounds = true
        panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(viewDidDragged))
        addGestureRecognizer(panGesture)
        selectedGesture = UILongPressGestureRecognizer.init(target: self, action: #selector(viewDidSelected))
        addGestureRecognizer(selectedGesture)
    }
    
    func viewDidDragged() {
        let newPoint = panGesture.location(in: self.superview)
        let newFrame = CGRect(x: newPoint.x - frame.width/2, y: newPoint.y - frame.height/2, width: frame.width, height: frame.height)
        frame = newFrame
        
        let width = self.superview!.frame.width
        let height = self.superview!.frame.height
        let x: Double = Double(newPoint.x / width)
        let y: Double = Double((height  - newPoint.y) / height)
        task.importance = x
        task.urgency = y
    }
    
    func viewDidSelected() {
        print("\(task.name)")
        
        /*let detailVC = DetailViewController()
        detailVC.nameTextField?.text = "\(task.name)"
        detailVC.dateTextField?.text = "\(task.dueDate)"
        detailVC.categoryTextField?.text = "\(task.category)"
        detailVC.taskLengthTextField?.text = "\(task.length)"
        
        detailVC.minChunkTextField?.text = ""
        detailVC.completionSlider?.value = 0.5
        detailViewController = detailVC*/
    }
    
}
