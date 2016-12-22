//
//  ExampleView1.swift
//  AnimationComparison
//
//  Created by Victor Sukochev on 21/12/2016.
//  Copyright © 2016 Victor Sukochev. All rights reserved.
//

import UIKit

class IntervalControlCG: UIView {
    @IBOutlet weak var internalLabel: UILabel?
    
    var value = 0 {
        didSet {
            if value == oldValue {
                return
            }
            
            updateIntevalLabel(currentValue: value)
            
            self.setNeedsDisplay()
            onValueChanged?(value)
        }
    }
    
    var onValueChanged: ( (Int) -> Void )?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        updateInterval(location: location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        updateInterval(location: location)
    }
    
    fileprivate func updateInterval(location: CGPoint) {
        let rx = self.bounds.width  / 2.0
        let ry = self.bounds.height / 2.0
        let x = Double((location.x - rx) / rx)
        let y = Double((location.y - ry) / ry)
        var angle = atan2(y, x) + M_PI_2
        if angle < 0.0 {
            angle = 2 * M_PI + angle
        }
        
        let progress = angle / ( 2.0 * M_PI)
        let currentValue = Int(25.0 * progress)
        if value == currentValue {
            return
        }
        
        value = currentValue
    }
    
    override func draw(_ rect: CGRect) {
        let progress = Double(value) / 25.0
        let angle = 2 * M_PI * progress
        let center = CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0)
        let r = center.x - 10.0
        
        let offset = CGFloat(-1.0 * M_PI / 2.0)
        let circlePath1 = UIBezierPath(
            arcCenter: center,
            radius: r,
            startAngle: offset, endAngle: offset + CGFloat(angle), clockwise: true)
        let circlePath2 = UIBezierPath(
            arcCenter: center,
            radius: r,
            startAngle: offset, endAngle: offset + CGFloat(angle), clockwise: false)
        
        UIColor.init(colorLiteralRed: 0.784, green: 0.784, blue: 0.784, alpha: 1.0).setStroke()
        UIColor.clear.setFill()
        circlePath1.lineWidth = 10.0
        circlePath1.stroke()
        
        UIColor.white.setStroke()
        circlePath2.lineWidth = 10.0
        circlePath2.stroke()
    }
    
    fileprivate func updateIntevalLabel(currentValue: Int) {
        internalLabel?.text = "\(currentValue)"
    }
}
