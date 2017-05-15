//
//  AxisView.swift
//  Productivize
//
//  Created by Bhairavi Chandersekhar on 5/15/17.
//  Copyright © 2017 Bhairavi Chandersekhar. All rights reserved.
//

import UIKit

class AxisView: UIView {


    override func draw(_ rect: CGRect) {
        drawAxes(rect)
        drawTriangles(rect)
        drawLabels(rect)
        drawTasks(rect)
    }
    
    func drawAxes(_ rect: CGRect) {
        let xAxis = UIBezierPath()
        xAxis.move(to: CGPoint(x:44, y:bounds.height - 40))
        xAxis.addLine(to: CGPoint(x:bounds.width - 15, y:bounds.height - 40 ))
        xAxis.close()
        xAxis.lineWidth = 3.0
        xAxis.stroke()
        
        let yAxis = UIBezierPath()
        yAxis.move(to: CGPoint(x:45, y:15))
        yAxis.addLine(to: CGPoint(x:45, y:bounds.height - 40 ))
        yAxis.close()
        UIColor.black.set()
        yAxis.lineWidth = 3.0
        yAxis.stroke()
    }
    
    func drawTriangles(_ rect: CGRect) {
        let xTriangle = UIBezierPath()
        xTriangle.move(to: CGPoint(x:bounds.width - 25, y:bounds.height - 35))
        xTriangle.addLine(to: CGPoint(x:bounds.width - 25, y:bounds.height - 45 ))
        xTriangle.addLine(to: CGPoint(x:bounds.width - 10, y:bounds.height - 40))
        xTriangle.addLine(to: CGPoint(x:bounds.width - 25, y:bounds.height - 35))
        xTriangle.close()
        xTriangle.stroke()
        xTriangle.fill()
        
        let yTriangle = UIBezierPath()
        yTriangle.move(to: CGPoint(x:40, y:25))
        yTriangle.addLine(to: CGPoint(x:50, y:25))
        yTriangle.addLine(to: CGPoint(x:45, y: 10))
        yTriangle.addLine(to: CGPoint(x:40, y:25))
        yTriangle.close()
        yTriangle.stroke()
        yTriangle.fill()
    }
    
    func drawLabels(_ rect: CGRect) {
        let urgentString: NSString = "URGENCY"
        let fieldColor: UIColor = UIColor.black
        let fieldFont = UIFont(name: "SFUIDisplay-Semibold", size: 15)
        let attributes: [String: Any] = [
            NSForegroundColorAttributeName: fieldColor,
            NSFontAttributeName: fieldFont!,
            NSKernAttributeName: 1.3
        ]
        urgentString.draw(in: CGRect(x: bounds.width/2 - 20, y: bounds.height - 30, width: 80, height: 40), withAttributes: attributes)
        
        let importanceLabel = importanceLabelView(frame: CGRect(x: 12, y: bounds.height/2 - 50, width: 20, height: 100))
        importanceLabel.attributedText = NSMutableAttributedString(string: "IMPORTANCE", attributes: attributes)
        
        self.addSubview(importanceLabel)
    }
    
    func drawTasks(_ rect: CGRect) {
        let width = Double(self.frame.width)
        let height = Double(self.frame.height)
        for task in Task.allTasks {
            let rect = CGRect(x: task.urgency * width, y: task.importance * height, width: 10, height: 10)
            let newView = TaskView(frame: rect, task: task)
            self.addSubview(newView)
        }
    }
}
