//
//  ExampleView1.swift
//  AnimationComparison
//
//  Created by Victor Sukochev on 21/12/2016.
//  Copyright © 2016 Victor Sukochev. All rights reserved.
//

import UIKit

class ExampleView1: UIView {
    var radius: CGFloat = 50.0
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: radius * 2.0, height: radius * 2.0))
        UIColor.blue.setStroke()
        path.stroke()
    }
}
