//
//  ExampleView1.swift
//  AnimationComparison
//
//  Created by Victor Sukochev on 21/12/2016.
//  Copyright © 2016 Victor Sukochev. All rights reserved.
//

import UIKit

class IntervalControlCG: UIView, IntervalControl {
    var progress: Double = 0.0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        let angle = CGFloat(M_PI * 2.0 * progress)
        let offset = CGFloat(-1.0 * M_PI / 2.0)
        let circlePath = UIBezierPath(
            arcCenter: self.center,
            radius: self.bounds.width / 2.0 - 5.0 - 2.0,
            startAngle: offset, endAngle: offset + angle, clockwise: false)
        
        UIColor.init(colorLiteralRed: 0.698, green: 0.823, blue: 0.207, alpha: 1.0).setStroke()
        UIColor.clear.setFill()
        circlePath.lineWidth = 10.0
        circlePath.stroke()
    }
    
}
