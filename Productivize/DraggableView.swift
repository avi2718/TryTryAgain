//
//  DraggableView.swift
//  Productivize
//
//  Created by Bhairavi Chandersekhar on 5/15/17.
//  Copyright © 2017 Bhairavi Chandersekhar. All rights reserved.
//

import UIKit

class DraggableView: UIView {
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setup () {
        backgroundColor = UIColor.cyan
        layer.cornerRadius = frame.size.width/2
        layer.masksToBounds = true
    }
    
}
