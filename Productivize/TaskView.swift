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
    var doubleTap = UITapGestureRecognizer()
    var task: Task
    var detailViewController = DetailViewController()
    var nameLabel: UILabel?
    
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
        
        //ADDS GESTURE RECOGNIZERS
        panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(viewDidDragged))
        addGestureRecognizer(panGesture)
        doubleTap = UITapGestureRecognizer.init(target: self, action: #selector(viewDidTapped))
         doubleTap.delaysTouchesBegan = true
    }
    
    func viewDidDragged() {
        //MOVES TASK VIEW
        let newPoint = panGesture.location(in: self.superview)
        let newFrame = CGRect(x: newPoint.x - frame.width/2, y: newPoint.y - frame.height/2, width: frame.width, height: frame.height)
        frame = newFrame
        
        let width = self.superview!.frame.width
        let height = self.superview!.frame.height
        let x: Double = Double(newPoint.x / width)
        //let y: Double = Double((height  - newPoint.y) / height)
        let y: Double = Double(newPoint.y / height)
        task.importance = y
        task.urgency = x
        
        //MOVES NAMELABEL
        let newNameFrame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y - 5, width: 80, height: 40)
        nameLabel?.frame = newNameFrame
    }
    
    
    func viewDidTapped() {
        print("\(task.name)")
        
        task.current = true
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
